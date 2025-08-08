using AdminService from '../../srv/admin-service';

annotate AdminService.Products with @(UI: {
    HeaderInfo         : {
        TypeName      : '{i18n>Product}',
        TypeNamePlural: '{i18n>Products}',
        Title         : {Value: name},
    // Description: {Value: ID},
    },
    Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>General}',
            Target: '@UI.FieldGroup#General'
        },
        // {
        // $Type : 'UI.ReferenceFacet',
        // Label : '{i18n>Translations}',
        // Target: 'texts/@UI.LineItem'
        // },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Details}',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Admin}',
            Target: '@UI.FieldGroup#Admin'
        },
    ],
    FieldGroup #General: {Data: [
        {Value: name},
        {Value: supplier.name},
        {Value: currency_code},
    ]},
    FieldGroup #Details: {Data: [
        {Value: description},
        {Value: price},
        {Value: currency_code},
    // {Label: '{i18n>Currency}'}
    ]},
    FieldGroup #Admin  : {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]},
    LineItem           : [
        {
            Value: ID,
            Label: '{i18n>ID}'
        },
        {
            Value: name,
            Label: '{i18n>ProductName}'
        },
        {Value: supplier.name},
        {Value: stock.quantity},
        {Value: price},
        {Value: currency.symbol},
    ]
})
