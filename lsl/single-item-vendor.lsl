/************ Track purchase - single item vendor ************
 * Tracks purchases in a vendor that sells a single item. This
 * must be a scripted vendor, ie not using the 'For sale' option 
 * of the Build Tool Box of the object. 
 *
 * This can be placed in any vendor that sells a single product
 * with a script.
 *
 * This script assumes the affiliate (or store) is the parcel's
 * name, the product name is the vendor object's name, product 
 * category is the vendor object's description, and the brand is
 * the owner's name. Feel free to change the values to your 
 * preference.
 ************************************************************/

integer gaRelayIncomingLinkNum = 282873400;

string owner;

send(key agent, string action, list params) {
    llMessageLinked(LINK_SET, gaRelayIncomingLinkNum, llList2CSV([agent] + params), (key)action);
}

ga_purchase(key agent, string locationLabel, string productName, integer quantity, integer price, integer revenue, string affiliate, string transactionId, string optionalSku, string optionalProductCategory, string optionalProductBrand, string optionalProductVariation, string referrer) {
    send(agent, "ga-purchase", [locationLabel, transactionId, affiliate, revenue, optionalSku, productName, optionalProductCategory, optionalProductBrand, optionalProductVariation, quantity, price, referrer]);
}
 
default
{
    state_entry() {
        owner = llKey2Name(llGetOwner());
    }
    
    changed(integer change) {
        if(change & CHANGED_OWNER) {
            llResetScript();
        }
    }

    money(key customer, integer amount) {
        string location = llList2String(llGetParcelDetails(llGetPos(), [PARCEL_DETAILS_NAME]), 0);
        integer quantity = 1;
        integer price = amount;
        integer revenue = amount;
        string storeName = location;
        string transactionId = (string)llGenerateKey();
        string sku = "";
        string productName = llGetObjectName();
        string productCategory = llGetObjectDesc();
        string brand = owner;
        string variation = "";
        string referrer = "";

        ga_purchase(customer, location, productName, quantity, price, revenue, storeName, transactionId, sku, productCategory, brand, variation, referrer);
    }
}
