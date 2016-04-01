Node = function( _nightbird ){

    var it = this;

    Nightbird.Node.call( it, _nightbird );
    it.name = 'Midi';
    it.width = 100;
    it.height = 45;

    it.value = 0;
    it.meedee = new Meedee();
    it.deviceID;
    it.MAX_MIDI_VALUE = 127;
    
    var outputValue = new Nightbird.Connector( it, true, 'number' );
    outputValue.setName( 'value' );
    outputValue.onTransfer = function(){
        return Number( it.value );
    };
    it.outputs.push( outputValue );
    it.move();
};

Node.prototype = Object.create( Nightbird.Node.prototype );
Node.prototype.constructor = Node;

Node.prototype.remove = function(){

    var it = this;

    it.meedee.offAll(it.deviceID);

    Nightbird.Node.prototype.remove.call( it );
};

Node.prototype.operateDown = function( _x, _y ){

    var it = this;

    if( Math.abs( 50-_x ) < 30 && Math.abs( 20-_y ) < 6 ) {
        if (it.lastClick && it.nightbird.time - it.lastClick < .3) {
            it.nightbird.textbox = new Nightbird.Textbox(it.nightbird, it.value, function (_value) {
                it.value = Number(_value);
            });
        } else {
            it.lastClick = it.nightbird.time;
            it.operateBeginY = _y;
            it.operateBeginValue = it.value;
            it.operate = true;
        }
        return true;
    }

    if( Math.abs( _x-70 ) < 19 && Math.abs( _y-38 ) < 6 ){
        it.operateLearn = true;

        //learn device ID by moving the knob
        it.meedee.on('any', function(value, event){

            it.meedee.offAll(it.deviceID);

            it.deviceID = event.data[1];
            it.value = value / it.MAX_MIDI_VALUE;

            it.meedee.on(it.deviceID, function(value){
                it.value = value / it.MAX_MIDI_VALUE;
            });

            it.meedee.offAll('any');
        });
        return true;
    }

    return false;

};

Node.prototype.operateMove = function( _x, _y ){

    var it = this;

    if( it.operate ){
        it.value = Number( ( it.operateBeginValue+(it.operateBeginY-_y)*.01 ).toFixed(3) );
    }

};

Node.prototype.operateUp = function(){

    var it = this;

    it.operate = false;
    it.operateLearn = false;
    it.meedee.offAll('any');
};

Node.prototype.save = function( _hashed ){

    var it = this;

    var obj = Nightbird.Node.prototype.save.call( it, _hashed );
    obj.value = it.value;
    return obj;

};

Node.prototype.draw = function(){

    var it = this;

    it.nightbird.modularContext.fillStyle = '#333';
    it.nightbird.modularContext.fillRect( it.posX, it.posY, it.width, it.height );
    it.nightbird.modularContext.fillStyle = it.operate ? '#777' : '#555';
    it.nightbird.modularContext.fillRect( it.posX+20, it.posY+14, 60, 12 );
    it.nightbird.modularContext.fillStyle = '#ddd';
    it.nightbird.modularContext.textAlign = 'center';
    it.nightbird.modularContext.textBaseline = 'middle';
    it.nightbird.modularContext.fillText( it.value.toFixed(3), it.posX+50, it.posY+20 );

    it.nightbird.modularContext.fillStyle = it.operateLearn ? '#777' : '#555';
    it.nightbird.modularContext.fillRect( it.posX+20, it.posY+30, 60, 12 );
    it.nightbird.modularContext.fillStyle = '#ddd';
    it.nightbird.modularContext.textAlign = 'center';
    it.nightbird.modularContext.textBaseline = 'middle';
    it.nightbird.modularContext.fillText( !isNaN(it.deviceID) ? it.deviceID : 'Learn', it.posX+50, it.posY+35 );

    Nightbird.Node.prototype.draw.call( it );

};
