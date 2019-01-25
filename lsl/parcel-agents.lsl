/**************** Track visit - parcel timer ****************
 * Checks for any new visitors to any of the owner's parcels
 * every 30 seconds, and triggers a hit every time someone new
 * appears or moves to a different parcel.
 *
 * Only one needs to be placed in a sim per parcel owner.
 *
 * LAG WARNING: since this has a somewhat frequest timer, be
 * be warned that too many of these on a sim can contribute to
 * lag. Consider using the phantom collision script for minimal 
 * lag.
 ************************************************************/

integer relayIncomingLinkNum = 282873400;

list visitors;

send(key agent, string action, list params) {
    llMessageLinked(LINK_SET, relayIncomingLinkNum, llList2CSV([agent] + params), (key)action);
}

ga_visit(key agent, string locationLabel, string referer) {
    send(agent, "ga-visit", [locationLabel, referrer]);
}

default
{
    state_entry() {
        llSetTimerEvent(30.0);
    }

    timer() {
        list agents =    llGetAgentList(AGENT_LIST_PARCEL_OWNER, []);
        list newVisitors = [];
        integer length = llGetListLength(agents);
        integer i;
        for (i = 0; i < length; i++) {
        key agent = llList2Key(agents, i);
        integer index = llListFindList(visitors, [agent]);
        vector pos = llList2Vector(llGetObjectDetails(agent, [OBJECT_POS]), 0);
        string parcelName = llList2String(llGetParcelDetails(pos, [PARCEL_DETAILS_NAME]), 0);
        if (!~index || llList2String(visitors, index + 1) != parcelName) {
            ga_visit(agent, parcelName, "");
        }
        newVisitors += [agent, parcelName];
        }
        visitors = newVisitors;
    }
}
