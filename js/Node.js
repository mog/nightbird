Nightbird.Node = function( _nightbird ){

	var node = this;

	node.nightbird = _nightbird;

	node.active = true;
	node.name = 'Node';
	node.nameColor = '#ddd';

	node.posX = 32;
	node.posY = 32;
	node.width = 100;
	node.height = 10;

	node.inputs = [];
	node.outputs = [];

	node.contextMenus = [];

	node.contextMenus.push( function(){
		var contextMenu = new Nightbird.ContextMenu( node.nightbird );
		contextMenu.setName( (function(){
			if( node.active ){ return 'Deactivate'; }
			else{ return 'Activate'; }
		}() ) );
		contextMenu.onClick = function(){
			node.active = !node.active;
		};
		return contextMenu;
	} );
	node.contextMenus.push( function(){
		var contextMenu = new Nightbird.ContextMenu( node.nightbird );
		contextMenu.setName( 'Disconnect' );
		contextMenu.onClick = function(){
			node.disconnect();
		};
		return contextMenu;
	} );
	node.contextMenus.push( function(){
		var contextMenu = new Nightbird.ContextMenu( node.nightbird );
		contextMenu.setName( 'Remove' );
		contextMenu.onClick = function(){
			node.remove();
		};
		return contextMenu;
	} );

};

Nightbird.Node.prototype.move = function( _x, _y ){

	var node = this;

	if( typeof _x == 'number' && typeof _y == 'number' ){
		node.posX = _x;
		node.posY = _y;
	}

	for( var i in node.inputs ){
		node.inputs[i].move( node.posX-12, node.posY+10+16*i );
	}
	for( var i in node.outputs ){
		node.outputs[i].move( node.posX+node.width+12, node.posY+10+16*i );
	}

};

Nightbird.Node.prototype.disconnect = function(){

	var node = this;

	for( var i=0; i<node.inputs.length; i++ ){
		var connector = node.inputs[i];
		if( connector.link ){
			node.nightbird.links.splice( node.nightbird.links.indexOf( connector.link ), 1 );
			connector.link.remove();
		}
	}
	for( var i=0; i<node.outputs.length; i++ ){
		var connector = node.outputs[i];
		for( var il=connector.link.length-1; 0<=il; il-- ){
			node.nightbird.links.splice( node.nightbird.links.indexOf( connector.link[i] ), 1 );
			connector.link[i].remove();
		}
	}

};

Nightbird.Node.prototype.remove = function(){

	var node = this;

	node.disconnect();
	node.nightbird.nodes.splice( node.nightbird.nodes.indexOf( node ), 1 );

};

Nightbird.Node.prototype.draw = function(){

	var node = this;

	node.nightbird.modularContext.globalAlpha = .8;
	if( node.active ){ node.nightbird.modularContext.fillStyle = '#567'; }
	else{ node.nightbird.modularContext.fillStyle = '#755'; }
	node.nightbird.modularContext.fillRect( node.posX, node.posY, node.width, 10 );

	node.nightbird.modularContext.globalAlpha = 1;
	node.nightbird.modularContext.fillStyle = node.nameColor;
	node.nightbird.modularContext.textAlign = 'left';
	node.nightbird.modularContext.textBaseline = 'center';
	if( !node.displayName ){
		node.displayName = '';
		for( var i=0; i<node.name.length; i++ ){
			node.displayName += node.name.charAt( i );
			if( node.width-20 < node.nightbird.modularContext.measureText( node.displayName ).width ){
				node.displayName += '...';
				break;
			}
		}
	}
	node.nightbird.modularContext.fillText( node.displayName, node.posX+3, node.posY+5 );

	for( var i in node.inputs ){
		node.inputs[i].draw();
	}
	for( var i in node.outputs ){
		node.outputs[i].draw();
	}

};