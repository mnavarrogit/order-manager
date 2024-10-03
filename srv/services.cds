using { mngt.orders as ord } from '../db/schemas';

@path: 'service/order'
service OrderService {

    entity Orders @(restrict : [
        {
            grant: ['WRITE'],
            to: ['Manager']
        },
        {
            grant: ['READ'],
            to: ['Viewer','Manager']
        }

    ]) as projection on ord.Orders;

    @readonly
    entity Products as projection on ord.Products;

}


annotate OrderService.Orders with @odata.draft.enabled;
annotate OrderService.Orders with @odata.draft.bypass;