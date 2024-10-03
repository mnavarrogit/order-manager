//@ui5-bundle orders/Component-preload.js
sap.ui.require.preload({
	"orders/Component.js":function(){
sap.ui.define(["sap/fe/core/AppComponent"],function(e){"use strict";return e.extend("orders.Component",{metadata:{manifest:"json"}})});
},
	"orders/i18n/i18n.properties":'# This is the resource bundle for orders\n\n#Texts for manifest.json\n\n#XTIT: Application name\nappTitle=Management Orders\n\n#YDES: Application description\nappDescription=Orders App\n\n#XFLD,39\nflpTitle=Orders Report\n',
	"orders/manifest.json":'{"_version":"1.65.0","sap.app":{"id":"orders","type":"application","i18n":"i18n/i18n.properties","applicationVersion":{"version":"0.0.1"},"title":"{{appTitle}}","description":"{{appDescription}}","resources":"resources.json","sourceTemplate":{"id":"@sap/generator-fiori:lrop","version":"1.15.1","toolsId":"dc54b251-ab2c-4d4f-9fd0-391ea6ebb4f6"},"dataSources":{"mainService":{"uri":"odata/v4/service/order/","type":"OData","settings":{"annotations":[],"odataVersion":"4.0"}}},"crossNavigation":{"inbounds":{"orders-list":{"semanticObject":"orders","action":"list","title":"{{flpTitle}}","signature":{"parameters":{},"additionalParameters":"allowed"}}}}},"sap.ui":{"technology":"UI5","icons":{"icon":"","favIcon":"","phone":"","phone@2":"","tablet":"","tablet@2":""},"deviceTypes":{"desktop":true,"tablet":true,"phone":true}},"sap.ui5":{"flexEnabled":true,"dependencies":{"minUI5Version":"1.128.1","libs":{"sap.m":{},"sap.ui.core":{},"sap.fe.templates":{}}},"contentDensities":{"compact":true,"cozy":true},"models":{"i18n":{"type":"sap.ui.model.resource.ResourceModel","settings":{"bundleName":"orders.i18n.i18n"}},"":{"dataSource":"mainService","preload":true,"settings":{"operationMode":"Server","autoExpandSelect":true,"earlyRequests":true}},"@i18n":{"type":"sap.ui.model.resource.ResourceModel","uri":"i18n/i18n.properties"}},"resources":{"css":[]},"routing":{"config":{},"routes":[{"pattern":":?query:","name":"OrdersList","target":"OrdersList"},{"pattern":"Orders({key}):?query:","name":"OrdersObjectPage","target":"OrdersObjectPage"},{"pattern":"Orders({key})/Items({key2}):?query:","name":"Orders_ItemsObjectPage","target":"Orders_ItemsObjectPage"}],"targets":{"OrdersList":{"type":"Component","id":"OrdersList","name":"sap.fe.templates.ListReport","options":{"settings":{"contextPath":"/Orders","variantManagement":"Page","navigation":{"Orders":{"detail":{"route":"OrdersObjectPage"}}},"controlConfiguration":{"@com.sap.vocabularies.UI.v1.LineItem":{"tableSettings":{"type":"ResponsiveTable"}}}}}},"OrdersObjectPage":{"type":"Component","id":"OrdersObjectPage","name":"sap.fe.templates.ObjectPage","options":{"settings":{"editableHeaderContent":false,"contextPath":"/Orders","navigation":{"Items":{"detail":{"route":"Orders_ItemsObjectPage"}}}}}},"Orders_ItemsObjectPage":{"type":"Component","id":"Orders_ItemsObjectPage","name":"sap.fe.templates.ObjectPage","options":{"settings":{"editableHeaderContent":false,"contextPath":"/Orders/Items"}}}}}},"sap.fiori":{"registrationIds":[],"archeType":"transactional"},"sap.cloud":{"public":true,"service":"orders"}}'
});
//# sourceMappingURL=Component-preload.js.map
