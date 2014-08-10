package 
{
  import flash.display.Sprite;
  import flash.system.Security;

  import vk.gui.*;

  /**
   * @author Alexey Kharkov
   */
  public class VkGuiLib extends Sprite 
  {
    public function VkGuiLib():void 
    {
      Security.allowDomain( "*" );
      
      var arr:Array = 
      [ 
        MainMenu,
        ComboBox,
        ListBox,
        RoundButton,
        SquareButton,
        LinkButton,
        LightButton,
        Box,
        CheckBox,
        RadioButton,
        RadioButtonsGroup,
        ScrollBar,
        InputField,
        Pagination
      ];
    }

  }
}