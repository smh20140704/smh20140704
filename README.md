smh20140704
===========


Hostelworld iOS technical test


Summary:

Create an iOS app (iPad or iPhone, your choice) that will obtain a list of property details from an online json resource and display them in a table view. Each element in the table will contain a sample image of the property and the property name. When the user clicks on a property in the table they'll be taken to a new page that will show a short description of the property.


Specifications:

The property details can be found by accessing http://www.gingermcninja.com/hw_test/propertylocationsearch.json. The app will need to access this data via a HTTP connection – it can't be included as a resource in the project. The property data is encoded under the 'result' key as follows:

Properties (array)
￼* name (string)
* address1 (string)
* address2 (string)
* type (string)
* starRating (string)
* avgRating (string)
* shortDescription (string)
* images (array)
  - width
  - height
  - url
* geo
  - longitude
  - latitude