package org.log5f.viewer.connection
{
	public class ConnectorFactory
	{
		internal static const registries:Vector.<IRegistry> = new Vector.<IRegistry>();
		
		public static function addRegistry(registry:IRegistry):void
		{
			registries.push(registry);
		}
		
		public static function getConnector(source:String):IConnector
		{
			for each (var registry:IRegistry in registries)
			{
				if (registry.identify(source))
					return registry.getConnector(source);
			}
			
			return null;
		}
	}
}