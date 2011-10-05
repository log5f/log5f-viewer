package org.log5f.viewer.view.components
{
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	import org.log5f.viewer.connection.ConnectorFactory;
	import org.log5f.viewer.connection.IConnector;
	import org.log5f.viewer.connection.events.ConnectorEvent;
	import org.log5f.viewer.view.components.events.AddressBarEvent;
	import org.log5f.viewer.view.components.events.ControlBarEvent;
	
	import spark.components.supportClasses.SkinnableComponent;
	
	public class ViewerPage extends SkinnableComponent
	{
		public function ViewerPage()
		{
			super();
		}
		
		private var connector:IConnector;
		
		[SkinPart]
		public var address:AddressBar;
		
		[SkinPart]
		public var output:OutputBox;
		
		[SkinPart]
		public var control:ControlBar;
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == this.address)
			{
				this.address.addEventListener(AddressBarEvent.SOURCE_CHANGE, address_changeHandler);
			}
			else if (instance == this.control)
			{
				this.control.addEventListener(ControlBarEvent.CLEAR, control_clearHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			
			if (instance == this.address)
			{
				this.address.addEventListener(AddressBarEvent.SOURCE_CHANGE, address_changeHandler);
			}
			else if (instance == this.control)
			{
				this.control.addEventListener(ControlBarEvent.CLEAR, control_clearHandler);
			}
		}
		
		private function setupConnector(source:String):void
		{
			this.connector = ConnectorFactory.getConnector(source);
			
			if (!this.connector)
			{
				// source invalid
				return;
			}
			
			this.connector.addEventListener(ConnectorEvent.SUCCESS, connector_successHandler);
			this.connector.addEventListener(ConnectorEvent.FAILURE, connector_failureHandler);
			this.connector.addEventListener(ConnectorEvent.PORTION, connector_portionHandler);
			
			try
			{
				this.connector.connect(source);
			}
			catch (error:ArgumentError)
			{
				// source invalid
			}
		}
		
		private function cleanConnector():void
		{
			if (!this.connector)
				return;
			
			this.connector.removeEventListener(ConnectorEvent.SUCCESS, connector_successHandler);
			this.connector.removeEventListener(ConnectorEvent.FAILURE, connector_failureHandler);
			this.connector.removeEventListener(ConnectorEvent.PORTION, connector_portionHandler);
			
			this.connector.close();
			
			this.connector = null;
		}
		
		protected function address_changeHandler(event:AddressBarEvent):void
		{
			if (this.connector)
				this.cleanConnector();
			
			this.setupConnector(event.source);
		}
		
		protected function control_clearHandler(event:ControlBarEvent):void
		{
			if (this.output)
				this.output.entries = null;
		}
		
		private function connector_successHandler(event:ConnectorEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function connector_failureHandler(event:ConnectorEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function connector_portionHandler(event:ConnectorEvent):void
		{
			if (!this.output) return;
			
			const list:IList = this.output.entries || new ArrayList();
			
			for each (var item:Object in event.data)
			{
				if (!item) continue;
				
				list.addItem(item);
			}
			
			this.output.entries = list;
		}
	}
}