using { com.nadsportfolio.inventory as my } from '../db/schema';
service CatalogService {

  /** For displaying lists of Products */
  @readonly entity ListOfProducts as projection on my.Products;

  /** For display in details pages */
  @readonly entity Products as projection on my.Products { *,
    supplier.name as supplier
  } excluding { createdBy, modifiedBy };

  // @requires: 'authenticated-user'
  // action updateProduct (
  //   product : Products:ID @mandatory,
  //   quantity: Integer  @mandatory
  // ) returns { stock: Integer };

  // event OrderedProduct : { product: Products:ID; quantity: Integer; buyer: String };
}
