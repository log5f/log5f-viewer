package org.log5f.viewer.connection
{
	public interface IRegistry
	{
		function identify(source:String):Boolean;
		
		function getConnector(source:String):IConnector;
	}
}