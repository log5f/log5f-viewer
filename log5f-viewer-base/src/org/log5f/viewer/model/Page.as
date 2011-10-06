package org.log5f.viewer.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Page extends EventDispatcher
	{
		public function Page(name:String=null)
		{
			super();
			
			this.name = name;
		}
		
		[Bindable]
		public var name:String;
	}
}