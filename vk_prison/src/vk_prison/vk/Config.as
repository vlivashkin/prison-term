package vk_prison.vk {
import flash.display.Stage;

import vk.APIConnection;

public class Config {
    private static var _instance:Config;
    internal var _flashVars:Object;
    internal var _VK:APIConnection;

    public function Config() {
        if(_instance){
            throw new Error("Singleton... use getInstance()");
        }
        _instance = this;
    }

    public static function getInstance():Config{
        if(!_instance){
            new Config();
        }
        return _instance;
    }

    public function initFlashVars(stage:Stage):void {
        _flashVars = stage.loaderInfo.parameters as Object;

        if (!_flashVars.api_id) {
            _flashVars['api_id'] = 4428337;
            _flashVars['viewer_id'] = 262968566;
            _flashVars['sid'] = "e6f8589c6ad1bd4822ca1dba8561765ddb228b4d7fc3acfc425da3bba6ad7ea8faf5bd56667c7c5ef8ff0";
            _flashVars['secret'] = "d1ea2a6010";
        }

        _VK = new APIConnection(_flashVars);
    }

    public function get VK():APIConnection {
        return _VK;
    }
}
}
