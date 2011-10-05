package org.log5f.viewer.view.components
{
	import flash.events.MouseEvent;
	
	import org.log5f.viewer.view.components.events.AddressBarEvent;
	
	import spark.components.Button;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	[Event(name="sourceChange", type="org.log5f.viewer.view.components.events.AddressBarEvent")]
	
	public class AddressBar extends SkinnableComponent
	{
		public function AddressBar()
		{
			super();
		}
		
		[SkinPart]
		public var sourceInput:TextInput;
		
		[SkinPart]
		public var goButton:Button;
		
		private var _source:String;
		
		public function get source():String
		{
			return this._source;
		}

		public function set source(value:String):void
		{
			if (value == this._source)
				return;
			
			this._source = value;
			
			if (this.sourceInput)
				this.sourceInput.text = this._source;
		}

		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == this.goButton)
			{
				this.goButton.addEventListener(MouseEvent.CLICK, goButton_clickHandler);
			}
			else if (instance == this.sourceInput)
			{
				this.sourceInput.text = this.source;
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			
			if (instance == this.goButton)
			{
				this.goButton.removeEventListener(MouseEvent.CLICK, goButton_clickHandler);
			}
			else if (instance == this.sourceInput)
			{
			}
		}
		
		private function goButton_clickHandler(event:MouseEvent):void
		{
			this._source = this.sourceInput ? this.sourceInput.text : null;
			
			this.dispatchEvent(new AddressBarEvent(AddressBarEvent.SOURCE_CHANGE, this.source));
		}		
		
	}
}