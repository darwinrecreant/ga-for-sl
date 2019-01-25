/************** Track visit - phantom collision **************
 * Triggers a hit every time the object is collided with. To
 * prevent unnecessary double hits when colliding a second
 * time, a list of collided avatars is maintained, and cleared
 * every hour when the avatar is no longer in the sim.
 *
 * This can be placed at the landing point of the parcel, or
 * at the entrance to every room.
 *
 * This can be used to track promotions/ads, by giving a
 * different landing point per ad, and placing this collider
 * there. Be sure to use the ga_promotion_event() function per
 * your needs, and only after the the line with ga_visit().
 ************************************************************/

integer relayIncomingLinkNum = 282873400;

list visitors;
integer ch;

send(key agent, string action, list params) {
    llMessageLinked(LINK_SET, relayIncomingLinkNum, llList2CSV([agent] + params), (key)action);
}

ga_visit(key agent, string locationLabel, string referrer) {
    send(agent, "ga-visit", [locationLabel, referrer]);
}

ga_promotion_event(key agent, string category, string action, string label, string promotionAction, string promotionId, string promotionName, string promotionBannerName, string promotionBannerSlot) {
    send(agent, "ga-promotion-event", [category, action, label, promotionAction, promotionId, promotionName, promotionBannerName, promotionBannerSlot]);
}

default
{
    state_entry() {
        llSetTimerEvent(3600.0);
        // Make prim phantom, this should be an invisible prim 
        // located at the landing point / entrance.
        llSetStatus(STATUS_PHANTOM, TRUE);
    }

    collision_start(integer total_number)
    {
        key agent = llDetectedKey(0);
        if(!~llListFindList(visitors, [agent])) {
            list details = llGetParcelDetails(llGetPos(), [PARCEL_DETAILS_NAME]);
            string parcelName = llList2String(details, 0);
            ga_visit(llDetectedKey(0), parcelName, "");
            visitors += [agent];
        }
    }

    timer() {
        integer i;
        for (i = llGetListLength(visitors) - 1; i >= 0; i--) {
        if (llGetAgentSize(llList2Key(visitors, i)) == ZERO_VECTOR) {
            visitors = llListReplaceList(visitors, [], i, i);
        }
        }
    }
}
