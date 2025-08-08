sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/nadsportfolio/inventory/inventoryui/test/integration/FirstJourney',
		'com/nadsportfolio/inventory/inventoryui/test/integration/pages/ProductsList',
		'com/nadsportfolio/inventory/inventoryui/test/integration/pages/ProductsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/nadsportfolio/inventory/inventoryui') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage
                }
            },
            opaJourney.run
        );
    }
);