# iconmerce
Senior Project repository for icon ecommerce app - iconmerce

This project included 3 separate yet related entities:
iconmerce-ui, iconmerce-api, and iconmerce-ios

iconmerce-ui is a web app ecommerce created in PHP using the LAMP stack.  It persists data and authorizes logins via a MySQL database hosted on Amazon Web Services (AWS).

iconmerce-api is a RESTful api created in PHP using a micro-framework called slim.  It uses PHP Data Objects(PDO) and NotORM to easily create endpoints for Create, Read, Update, Delete (CRUD) operations on the MySQL database and return results in JSON format.

iconmerce-ios is an iOS app version of the ecommerce store.  It is created in Swift and uses the iconmerce-api endpoints to talk to the database.
