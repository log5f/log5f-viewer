package org.log5f.viewer.view.components
{
	import flash.events.MouseEvent;
	
	import org.log5f.viewer.view.components.events.ControlBarEvent;
	
	import spark.components.Button;
	import spark.components.supportClasses.SkinnableComponent;
	
	[Event(name="clear", type="org.log5f.viewer.view.components.events.ControlBarEvent")]
	
	public class ControlBar extends SkinnableComponent
	{
		public function ControlBar()
		{
			super();
		}
		
		[SkinPart]
		public var clearButton:Button;
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == this.clearButton)
			{
				this.clearButton.addEventListener(MouseEvent.CLICK, clearButton_clickHandler);
			}
		}

		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);

			if (instance == this.clearButton)
			{
				this.clearButton.removeEventListener(MouseEvent.CLICK, clearButton_clickHandler);
			}
		}
		
		private function clearButton_clickHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new ControlBarEvent(ControlBarEvent.CLEAR));
		}
	}
}