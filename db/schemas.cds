using { Currency, User, managed, cuid, sap.common.CodeList } from '@sap/cds/common';
namespace mngt.orders;

entity Orders: cuid, managed {
    OrderNo: String(22) @title : 'Order Number';
    Items: Composition of many {
        key ID: UUID;
        product: Association to Products;
        quantity: Integer;
        unit: Association to Mensure;
        material: String;
        price: Double;
    };
    buyer: User;
    Currency: Currency;
    status: Association to Status default 'N';
    status_txt: String;
    criticality: Integer;
    netAmount: Double;
    qtyTotal: Integer;
    orderSAP: String;
}

entity Products  {
    key ID: String;
    quantity: Decimal(13, 2);
    unitMensure: Association to Mensure;
    product_ID: String;
    title: String;
    price: Double;
}

entity Status : CodeList {
    key code: String enum {
        new = 'N';
        approved = 'A';
        closed = 'C';
    };
    
}

entity Mensure : CodeList {
    key code: String(2) enum {
        kilo = 'KL';
        unit = 'UN';
    };
}
