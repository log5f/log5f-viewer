package org.log5f.viewer.view.components
{
	import mx.collections.IList;
	
	import spark.components.supportClasses.ListBase;
	import spark.components.supportClasses.SkinnableComponent;
	
	public class OutputBox extends SkinnableComponent
	{
		public function OutputBox()
		{
			super();
		}
		
		[SkinPart]
		public var list:ListBase;
		
		private var _entries:IList;

		public function get entries():IList
		{
			return _entries;
		}

		public function set entries(value:IList):void
		{
			if (value == this._entries)
				return;
			
			_entries = value;
			
			if (this.list)
				this.list.dataProvider = this.entries;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == this.list)
			{
				this.list.dataProvider = this.entries;
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
		}
		
		
	}
}