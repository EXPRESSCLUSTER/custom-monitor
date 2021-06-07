# How to monitor teamed NIC on Windows

## Overview
This article shows how to monitor teamed NIC (called "member") on Windows environment.

## Monitor Setup
e.g.) "local-1" NIC and "local-2" NIC are teamed with teaming name "team-1" on all cluster nodes.

### On all cluster nodes
1. Make Powershell scripts executable:
	```bat
	PS> Set-ExecutionPolicy RemoteSigned
	```
1. Download [script](https://github.com/EXPRESSCLUSTER/custom-monitor/blob/main/Teamed%20NIC%20monitor/teamedNicMonitor.ps1) and make its copies for each NIC.
	- e.g.)
		- C:\Program Files\EXPRESSCLUSTER\scripts\custom-monitor\teamedNicMonitor-1.ps1
		- C:\Program Files\EXPRESSCLUSTER\scripts\custom-monitor\teamedNicMonitor-2.ps1
1. Set member NIC name on each copied script.
	- e.g.)
		- teamedNicMonitor-1.ps1
			```bat
			# Set member NIC name
			$memberName = "loacl-1"
			```
		- teamedNicMonitor-2.ps1
			```bat
			# Set member NIC name
			$memberName = "loacl-2"
			```
1. Execute the copied scripts manualy to check whether they work properly.

### On Cluster WebUI
1. Start Cluster WebUI Config Mode.
1. Add 2 custome monitor resources and set as follows:
	- genw1
		- Info
			- Type: Custome monitor
			- Name: genw1
		- Monitor(Common)
			- Monitor Timing: Always
		- Monitor(Special)
			- User Application: Check
			- File: C:\Program Files\EXPRESSCLUSTER\scripts\custom-monitor\teamedNicMonitor-1.ps1
			- Monitor Type: Synchronous
			- Normal Return Value: 0
		- About other settings, please set as you like or default.
	- genw2
		- Info
			- Type: Custome monitor
			- Name: genw2
		- Monitor(Common)
			- Monitor Timing: Always
		- Monitor(Special)
			- User Application: Check
			- File: C:\Program Files\EXPRESSCLUSTER\scripts\custom-monitor\teamedNicMonitor-2.ps1
			- Monitor Type: Synchronous
			- Normal Return Value: 0
		- About other settings, please set as you like or default.
1. Apply the configuration to the cluster.
