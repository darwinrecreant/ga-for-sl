/**************** Track visit - parcel timer ****************
 * Tracks when a button / object is touched. Assumes category
 * is the object's name, action is "Touch", label is the name 
 * of the link prim that was touched. Feel free to change the 
 * values to your preference.
 ************************************************************/

integer relayIncomingLinkNum = 282873400;

send(key agent, string action, list params) {
    llMessageLinked(LINK_SET, relayIncomingLinkNum, llList2CSV([agent] + params), (key)action);
}
 
ga_event(key agent, string category, string action, string label, string value) {
    send(agent, "ga-event", [category, action, label, value]);
}

default
{
    touch_start(integer total_number)
    {
        list details = llGetParcelDetails(llGetPos(), [PARCEL_DETAILS_NAME]);
        string buttonName = llGetLinkName(llDetectedLinkNumber(0));
        string object = llGetObjectName();
        ga_event(llDetectedKey(0), object, "Touch", buttonName, "");
    }
}
