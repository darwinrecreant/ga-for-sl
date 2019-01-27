/**************** Track visit - parcel timer ****************
 * Tracks when a button / object is touched. Assumes category
 * is current parcel's name, action is "Touch", label is
 * the object's name, and button name is the name of the link 
 * prim that was touched.
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
        string parcelName = llList2String(details, 0);
        string buttonName = llGetLinkName(llDetectedLinkNumber(0));
        ga_event(llDetectedKey(0), parcelName, "Touch", llGetObjectName(), buttonName);
    }
}
