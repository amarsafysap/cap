using { sap.capire.bookshop as my } from '../db/schema';
service CatalogService {

  /** For displaying lists of Books */
 entity ListOfBooks as projection on Books
  excluding { descr };

  /** For display in details pages */
  entity Books as projection on my.Books { *,
    author.name as author
  } excluding { createdBy, modifiedBy };

  @requires: 'authenticated-user'
  action submitOrder (
    book    : Books:ID @mandatory,
    quantity: Integer  @mandatory
  ) returns { stock: Integer };

  event OrderedBook : { book: Books:ID; quantity: Integer; buyer: String };
}
