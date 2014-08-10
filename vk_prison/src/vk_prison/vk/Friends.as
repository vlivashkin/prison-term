/**
 * Created by wawilon on 11.08.2014.
 */
package vk_prison.vk {
import flash.display.Stage;

import vk.APIConnection;

public class Friends {
    public function Friends(stage:Stage) {
        this.stage = stage;
        flashVars = stage.loaderInfo.parameters as Object;

        if (!flashVars.api_id) {
            flashVars['api_id'] = 4428337;
            flashVars['viewer_id'] = 41624918;
            flashVars['sid'] = "49cebb47d3ea03abba45d7b118eff6c71e365162c2207dc80cb7965417dd5b83b1b682952caaaa76a853b";
            flashVars['secret'] = "c2622ebb94";
        }

        VK = new APIConnection(flashVars);
    }
    internal var stage:Stage;
    internal var flashVars:Object;
    internal var VK:APIConnection;

    public function getFriendsList(onSuccess:Function):void {
        VK.api('friends.getAppUsers', {
        }, function(data:Object):void {
            getFriendsNames(data.toString(), onSuccess);
        }, function(data:Object):void {
            trace("Fail friends.getAppUsers with error_msg: " + data.error_msg + "\n");
        });
    }

    public function getFriendsNames(uids:String, onSuccess:Function):void {
        VK.api('users.get', {uids : uids, fields : "uid, first_name, last_name, photo"},
        function(data:Object):void {
            onSuccess(data);
        }, function(data:Object):void {
            trace("Fail friends.getAppUsers with error_msg: " + data.error_msg + "\n");
        });
    }
}
}
