package mint.render.luxe;

import luxe.Vector;
import mint.types.Types;
import mint.render.Rendering;

import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;

import phoenix.geometry.QuadGeometry;
import luxe.Color;
import luxe.Log.*;

private typedef LuxeMintCanvasOptions = {
    var color: Color;
}

class Canvas extends mint.render.Render {

    public var canvas : mint.Canvas;
    public var visual : QuadGeometry;

    public var color : Color;

    var render: LuxeMintRender;

    public function new(_render:LuxeMintRender, _control:mint.Canvas) {

        canvas = _control;
        render = _render;

        super(render, _control);

        var _opt: LuxeMintCanvasOptions = canvas.options.options;

        color = def(_opt.color, new Color(0,0,0,0).rgb(0x0c0c0c));

        visual = Luxe.draw.box({
            id: control.name+'.visual',
            batcher: render.options.batcher,
            x: sx,
            y: sy,
            w: sw,
            h: sh,
            color: color,
            depth: render.options.depth + control.depth,
            visible: control.visible,
            clip_rect: Convert.bounds(control.clip_with, scale)
        });

    } //new

    override function onscale(_scale:Float, _prev_scale:Float) {
    
        visual.clip_rect = Convert.bounds(control.clip_with, _scale);
    
    } //onscale

    override function ondestroy() {

        visual.drop();
        visual = null;

    } //ondestroy

    override function onbounds() {

        visual.transform.pos.set_xy(sx, sy);
        visual.resize_xy(sw, sh);

    } //onbounds

    override function onclip(_disable:Bool, _x:Float, _y:Float, _w:Float, _h:Float) {
        
        visual.clip_rect = Convert.bounds(control.clip_with, scale);
        
    } //onclip

    override function onvisible(_visible:Bool) {

        visual.visible = _visible;

    } //onvisible

    override function ondepth(_depth:Float) {

        visual.depth = render.options.depth + _depth;

    } //ondepth

} //Canvas
