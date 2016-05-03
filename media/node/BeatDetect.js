Node = function( _nightbird ){

    var it = this;

    Nightbird.Node.call( it, _nightbird );
    it.name = 'BeatDetect';
    it.width = 100;
    it.height = 63;

    it.bass = 0;
    it.medium = 0;
    it.high = 0;

    it.beat = new Rythm();
    it.beat.plugMicrophone();

//--
    var bassValue = new Nightbird.Connector( it, true, 'number' );
    bassValue.setName( 'bass' );

    it.beat.addRythm(function(a){
        it.bass = +a || 0;
    }, 0, 10);

    bassValue.onTransfer = function(){
        return Number(it.bass);
    };
    it.outputs.push( bassValue );
//--
    var mediumValue = new Nightbird.Connector( it, true, 'number' );
    mediumValue.setName( 'medium' );

    it.beat.addRythm(function(a){
        it.medium = +a || 0;
    }, 150, 40);

    mediumValue.onTransfer = function(){
        return Number(it.medium);
    };
    it.outputs.push( mediumValue );
//--
    var highValue = new Nightbird.Connector( it, true, 'number' );
    highValue.setName( 'high' );

    it.beat.addRythm(function(a){
        it.high = +a || 0;
    }, 500, 100);

    highValue.onTransfer = function(){
        return Number(it.high);
    };
    it.outputs.push( highValue );
//--
    it.beat.start();
    it.move();
};

Node.prototype = Object.create( Nightbird.Node.prototype );
Node.prototype.constructor = Node;

Node.prototype.remove = function(){

    var it = this;

    //it.meedee.offAll(it.deviceID);

    Nightbird.Node.prototype.remove.call( it );
};

Node.prototype.operateDown = function( _x, _y ){

    var it = this;
};

Node.prototype.operateMove = function( _x, _y ){

    var it = this;
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
    obj.highValue = it.highValue;
    obj.mediumValue = it.mediumValue;
    obj.bassValue = it.bassValue;
    return obj;

};

Node.prototype.draw = function(){

    var it = this;

    it.nightbird.modularContext.fillStyle = '#333';
    it.nightbird.modularContext.fillRect( it.posX, it.posY, it.width, it.height );
    it.nightbird.modularContext.fillStyle = it.operate ? '#777' : '#555';
    it.nightbird.modularContext.fillStyle = '#ddd';
    it.nightbird.modularContext.textAlign = 'center';
    it.nightbird.modularContext.textBaseline = 'middle';
    it.nightbird.modularContext.fillText( it.bass.toFixed(3),  it.posX+50, it.posY+20 );
    it.nightbird.modularContext.fillText( it.medium.toFixed(3),it.posX+50, it.posY+35 );
    it.nightbird.modularContext.fillText( it.high.toFixed(3),  it.posX+50, it.posY+50 );


    Nightbird.Node.prototype.draw.call( it );

};
