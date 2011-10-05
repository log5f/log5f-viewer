package org.log5f.viewer.view.components.events
{
	import flash.events.Event;
	
	public class AddressBarEvent extends Event
	{
		public static const SOURCE_CHANGE:String = "sourceChange";
		
		public function AddressBarEvent(type:String, source:String=null, bubbles:Boolean=false, cnacelable:Boolean=false)
		{
			super(type, bubbles, cnacelable);
			
			this._source = source;
		}
		
		private var _source:String;
		
		public function get source():String
		{
			return this._source;
		}
	}
}