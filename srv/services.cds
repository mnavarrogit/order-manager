using { mngt.orders as ord } from '../db/schemas';
using { API_SALES_ORDER_SRV as external } from './external/API_SALES_ORDER_SRV';


@path: 'service/order'
service OrderService {

//    entity Orders @(restrict : [
//        {
//            grant: ['WRITE'],
//            to: ['Manager']
//        },
//        {
//            grant: ['READ'],
//            to: ['Viewer','Manager']
//        }
//
//    ]) as projection on ord.Orders;

    entity Orders as projection on ord.Orders order by OrderNo asc actions {
        @Common.IsActionCritical
        action Create_Order();
    };

    @readonly
    entity Products as projection on ord.Products;

    @readonly
    entity SalesOrder as projection on external.A_SalesOrder;
}


annotate OrderService.Orders with @odata.draft.enabled;
annotate OrderService.Orders with @odata.draft.bypass;