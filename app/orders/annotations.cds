using OrderService as service from '../../srv/services';
using from '@sap/cds/common';
using from '../../db/schemas';


annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : OrderNo,
                Label : '{i18n>OrderNumber}',
            },
            {
                $Type : 'UI.DataField',
                Value : buyer,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Total',
                Value : netAmount,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Currency}',
                Value : Currency_code,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Status}',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : qtyTotal,
                Label : '{i18n>TotalQuantity}',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Order Detail',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Order Items',
            ID : 'OrderItems',
            Target : 'Items/@UI.LineItem#OrderItems',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : OrderNo,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : buyer,
            ![@UI.Importance] : #Medium,
        },
        {
            $Type : 'UI.DataField',
            Value : netAmount,
            Label : 'Total',
        },
        {
            $Type : 'UI.DataField',
            Label : 'Currency',
            Value : Currency_code,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>StatusCode}',
            Value : status_code,
            Criticality : criticality,
            CriticalityRepresentation : #WithIcon,
            ![@UI.Importance] : #High,
        },
    ],
    UI.SelectionFields : [
        buyer,
        OrderNo,
    ],
    UI.DataPoint #progress : {
        $Type : 'UI.DataPointType',
        Value : criticality,
        Title : 'Status',
        TargetValue : 3,
        Visualization : #Progress,
        ![@Common.QuickInfo] : status.name,
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'criticality',
            Target : '@UI.DataPoint#progress',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Order',
        TypeNamePlural : 'Orders',
        Title : {
            $Type : 'UI.DataField',
            Value : OrderNo,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : 'OrderNumber',
        },
        TypeImageUrl : 'sap-icon://my-sales-order',
    },
);

annotate service.Orders with {
    buyer @(
        Common.FieldControl : #Mandatory,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Orders',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : buyer,
                    ValueListProperty : 'buyer',
                },
            ],
            Label : 'Buyer',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Orders with {
    Currency @Common.Text : {
        $value : Currency.name,
        ![@UI.TextArrangement] : #TextFirst
    }
};

annotate service.Orders with {
    status @(
        Common.Text : {
            $value : status_txt,
            ![@UI.TextArrangement] : #TextLast
        },
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_code,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Status',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Status with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextLast,
    }
};

annotate service.Orders with {
    OrderNo @(
        Common.Text : buyer,
        Common.FieldControl : #Mandatory,
    )
};

annotate service.Orders with {
    netAmount @Common.FieldControl : #ReadOnly
};

annotate service.Orders with {
    qtyTotal @Common.FieldControl : #ReadOnly
};

annotate service.Orders.Items with @(
    UI.LineItem #OrderItems : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : product_ID,
            Label : 'Product',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : material,
            Label : 'Title',
            ![@UI.Importance] : #Medium,
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'Quantity',
            ![@UI.Importance] : #Medium,
        },
        {
            $Type : 'UI.DataField',
            Value : unit_code,
            Label : 'Unit',
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            Label : 'Price',
            ![@UI.Importance] : #High,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Item Detail',
            ID : 'ItemDetail',
            Target : '@UI.FieldGroup#ItemDetail',
        },
    ],
    UI.FieldGroup #ItemDetail : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'Item ID',
            },
            {
                $Type : 'UI.DataField',
                Value : product_ID,
                Label : 'Product',
            },
            {
                $Type : 'UI.DataField',
                Value : material,
                Label : 'Description',
            },
            {
                $Type : 'UI.DataField',
                Value : quantity,
                Label : 'Quantity',
            },
            {
                $Type : 'UI.DataField',
                Value : price,
                Label : 'Price',
            },
            {
                $Type : 'UI.DataField',
                Value : unit_code,
                Label : 'Mensure Unit',
            },
        ],
    },
    UI.DataPoint #rating : {
        $Type : 'UI.DataPointType',
        Value : quantity,
        Title : 'Rating based on quantity',
        TargetValue : 5,
        Visualization : #Rating,
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'quantity',
            Target : '@UI.DataPoint#rating',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Item',
        TypeNamePlural : 'Items',
        Title : {
            $Type : 'UI.DataField',
            Value : material,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : 'Product',
        },
        TypeImageUrl : 'sap-icon://customer-order-entry',
    },
);

annotate service.Orders.Items with {
    ID @Common.FieldControl : #ReadOnly
};

annotate service.Orders.Items with {
    product @(
        Common.FieldControl : #Mandatory,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : product_ID,
                    ValueListProperty : 'product_ID',
                },
            ],
            Label : 'Products',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Orders.Items with {
    material @Common.FieldControl : #ReadOnly
};

annotate service.Orders.Items with {
    quantity @Common.FieldControl : #Mandatory
};

annotate service.Orders.Items with {
    price @(
        Common.FieldControl : #ReadOnly,
        Measures.ISOCurrency : up_.Currency_code,
    )
};

annotate service.Orders.Items with {
    unit @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Mensure',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : unit_code,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Unit',
        },
        Common.ValueListWithFixedValues : true
)};

annotate service.Mensure with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextLast,
    }
};
annotate service.Products with {
    product_ID @Common.Text : {
        $value : title,
        ![@UI.TextArrangement] : #TextLast,
    }
};

