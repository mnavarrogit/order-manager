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

        return super.init();
    }

}

module.exports = OrdersService;