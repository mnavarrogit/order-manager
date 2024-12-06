const { update } = require('@sap/cds');
const cds = require ('@sap/cds')

class OrdersService extends cds.ApplicationService {

    init(){

        const { 'Orders': Orders, 'Orders.Items': OrderItems } = this.entities
    
        this.after('READ', Orders, async function(data) {

            const orders = Array.isArray(data) ? data : [data];
            let totalAmount;
            let totalQty;

            for(let order of orders){

                totalAmount = 0;
                totalQty = 0;
                let Order_Items = await SELECT.from (OrderItems).where `up__ID=${order.ID}`;
                for(let i of Order_Items){
                    totalAmount = totalAmount + (i.quantity * i.price);
                    totalQty = totalQty + i.quantity;
                }
                order.netAmount = totalAmount;
                order.qtyTotal = totalQty; 

                switch  (order.status_code) {
                    case 'N': 
                        order.criticality = 1;
                        order.status_txt = 'New';
                        break;
                    case 'A':
                        order.criticality = 2;
                        order.status_txt = 'Approved';
                        break;
                    case 'C':
                        order.criticality = 3;
                        order.status_txt = 'Closed';
                        break;
                    default:
                        break;    

                }
                console.log('Order');
                console.log(order);
            }
        })
        

        this.on('READ','SalesOrder', async function(req) {
            //conexion a SAP S4
            const s4SORead = await cds.connect.to('API_SALES_ORDER_SRV');
            return s4SORead.run(req.query);

        })

        //handle post call
        this.on('Create_Order', async function(req) {
            
            console.log("Sync Order ID: " + req.params);
            //conecta db
            const orderDB = await cds.connect.to('OrderService');
            const s4Service = await cds.connect.to('API_SALES_ORDER_SRV');
            const s4e = s4Service.entities;

            //recupera ID
            const params = req.params;
            if(params != null){
                for(let i = 0; i < params.length; i++) {
                    if(params[i].ID != null){

                        //busca datos de orden
                        let query = SELECT.from (Orders).where `ID=${params[i].ID}`;
                        let order = await orderDB.run(query);

                        //verifica orden aprobada
                        if(order[0].status_code != 'A'){
                            req.info(400, 'Order ID: ' + params[i].ID + ' no se permite sincronizar order con status ' + order[0].status_code +
                                ' ' + order[0].status_txt);
                            console.log("Sync order ID: " + order);    
                            return req;
                        }

                        //header sales order
                        let SalesOrderType = "ZCUP",
                            SalesOrganization = "C002",
                            DistributionChannel = "01",
                            PurchaseOrderByCustomer = order[0].OrderNo,
                            SoldToParty = "1";

                        //busca item de orden
                        query = SELECT.from (OrderItems).where `up__ID=${params[i].ID}`;    
                        let ordItems = await orderDB.run(query);
                        
                        const to_Item = new Array();

                        //items sales order
                        for(let i=0;i < ordItems.length; i++){
                            to_Item.push({
                                SalesOrderItem: String(i+10),
                                Material: ordItems[i].product_ID,
                                RequestedQuantity: String(ordItems[i].quantity)
                            });
                        }

                        //payload debug
                        const payload = {
                            "SalesOrderType": SalesOrderType,
                            "SalesOrganization": SalesOrganization,
                            "DistributionChannel": DistributionChannel,
                            "PurchaseOrderByCustomer": PurchaseOrderByCustomer,
                            "SoldToParty": SoldToParty,
                            "to_Item": to_Item
                        }

                        console.log(JSON.stringify(payload));

                        //crear sales order en s4
                        const salesOrder = await s4Service.run(
                            INSERT({
                                SalesOrderType,
                                SalesOrganization,
                                DistributionChannel,
                                PurchaseOrderByCustomer,
                                SoldToParty,
                                to_Item
                            }).into(s4e.A_SalesOrder)
                        );

                        console.log(JSON.stringify(salesOrder));

                        //actualiza datos en tabla de ordenes
                        await UPDATE.entity(Orders, params[i].ID)
                              .set({status_code:'C', orderSAP: salesOrder.SalesOrder});

                        req.info(400, 'Order ID: ' + params[i].ID + 'Sync exitoso! Orden SAP: ' + salesOrder.SalesOrder);      

                    }
                }
            }

            req.reply();
        })

        return super.init();
    }

}

module.exports = OrdersService;