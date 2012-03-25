import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.external.ExternalInterface;

class ButtonUp extends MovieClip { public function new() { super(); } }
class ButtonOver extends MovieClip { public function new() { super(); } }
class ButtonDown extends MovieClip { public function new() { super(); } }

class Clippy {
  // Main
  static function main() {
    var id:String = flash.Lib.current.loaderInfo.parameters.id;
    var copied:String = flash.Lib.current.loaderInfo.parameters.copied;
    var copyto:String = flash.Lib.current.loaderInfo.parameters.copyto;
    if(copied == null){ copied = "copied!";};
    if(copyto == null){ copyto = "copy to clipboard";};

    flash.Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    flash.Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;

    // label

    var label:TextField = new TextField();
    var format:TextFormat = new TextFormat("Arial", 10);

    label.text = copyto;
    label.setTextFormat(format);
    label.textColor = 0x888888;
    label.selectable = false;
    label.x = 15;
    label.visible = false;

    flash.Lib.current.addChild(label);

    // button

    var button:SimpleButton = new SimpleButton();
    button.useHandCursor = true;
    button.upState = flash.Lib.attach("ButtonUp");
    button.overState = flash.Lib.attach("ButtonOver");
    button.downState = flash.Lib.attach("ButtonDown");
    button.hitTestState = flash.Lib.attach("ButtonDown");

    button.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent) {
      flash.system.System.setClipboard(ExternalInterface.call("(function(id){elem=document.getElementById(id);if(elem){ if ( typeof elem.textContent === 'string' ) { return elem.textContent; } else if ( typeof elem.innerText === 'string' ) { return elem.innerText.replace( /\\r\\n/g, '' ); } }else{alert('WARN: ' + id + ' Not found ');}})",id));
      ExternalInterface.call("(function(id){if(clippyCopiedCallback){ clippyCopiedCallback(id)}})", id);
      label.text = copied;
      label.setTextFormat(format);
    });

    button.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent) {
      label.visible = true;
    });

    button.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent) {
      label.visible = false;
      label.text = copyto;
      label.setTextFormat(format);
    });

    flash.Lib.current.addChild(button);
  }
}
