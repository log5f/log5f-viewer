package org.log5f.viewer.connection.impl
{
	import org.log5f.viewer.connection.IConnector;
	import org.log5f.viewer.connection.IRegistry;
	
	public class NetGroupRegistry implements IRegistry
	{
		public function NetGroupRegistry()
		{
		}
		
		public function identify(source:String):Boolean
		{
			return source && source.indexOf("rtmfp://") == 0;
		}
		
		public function getConnector(source:String):IConnector
		{
			return new NetGroupConnector();
		}
	}
}