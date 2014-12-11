package mint.render;

import mint.Types;
import luxe.Rectangle;
import luxe.Text;
import luxe.Vector;
import luxe.Input;

class LuxeMintRenderer extends Renderer {

    override function render<T:Control>( type:Class<T>, control:T ) {
        switch(type) {
            case mint.Canvas: follow(control, new mint.render.Canvas(this, cast control));
            case mint.Label: follow(control, new mint.render.Label(this, cast control));
            case mint.Button: follow(control, new mint.render.Button(this, cast control));
            case mint.Image: follow(control, new mint.render.Image(this, cast control));
            case mint.ScrollArea: follow(control, new mint.render.Scroll(this, cast control));
        }
    } //render

} //LuxeMintRender