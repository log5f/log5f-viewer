package org.log5f.viewer.view.components.events
{
	import flash.events.Event;
	
	public class ControlBarEvent extends Event
	{
		public static const CLEAR:String = "clear";
		
		public function ControlBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}