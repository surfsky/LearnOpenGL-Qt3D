pragma Singleton

import QtQuick 2.7

Item { // This is the global resource router
	// FIXME: bad routine and different versions with format in C++

	readonly property var os2Prefix: {
		"android"	: "file:/sdcard/Documents/QML Projects/Examples" ,
		// "android"	: "assets://" ,
		// Compatibility for QML Creator
		"linux"		: "file:.." ,
		"osx"		: "file:.." ,
		"unix"		: "file:.." ,
		"windows"	: "file:.." ,
	}

	property bool appRcEnabled: false
	property bool assetsRcEnabled: false

	function setGlInfo(info) {
		if (info.profile === 1) {
			shaderType = "gl33";
		} else {
			if (info.majorVersion >= 3) {
				shaderType = "es30";
			} else {
				shaderType = "es20";
			}
		}

		var text = "Open%4 %1.%2 %3".arg(info.majorVersion)
			.arg(info.minorVersion).arg({
				0: "NoProfile",
				1: "CoreProfile",
				2: "CompatibilityProfile"
			}[info.profile]).arg({
				0: "Unspecified",
				1: "GL",
				2: "GLES"
			}[info.renderableType])
		;

		console.log("[Resources] GL format: %1".arg(text));
		console.log("[Resources] shaderType: %1".arg(shaderType));
	}

	property string appPrefix: (appRcEnabled?"qrc:":os2Prefix[Qt.platform.os])+ "/"
	property string assetsPrefix: (assetsRcEnabled?"qrc:":os2Prefix[Qt.platform.os])+ "/"

	property string shaderType: "gl33"
    readonly property string shaderPrefix: appPrefix + "shaders/" + shaderType + "/"
	function shader(fn){return shaderPrefix + fn;}

    readonly property string texturePrefix: assetsPrefix + "assets/texture/"
	function texture(fn){return texturePrefix + fn;}
    readonly property string imagePrefix: assetsPrefix + "assets/image/"
	function image(fn){return imagePrefix + fn;}
    readonly property string meshPrefix: assetsPrefix + "assets/mesh/"
	function mesh(fn){return meshPrefix + fn;}
    readonly property string modelPrefix: assetsPrefix + "assets/model/"
	function model(fn){return modelPrefix + fn;}

	onAppPrefixChanged: {
		console.log("[Resources] app: %1 : %2".arg(appRcEnabled).arg(appPrefix));
	}

	onAssetsPrefixChanged: {
		console.log("[Resources] assets: %1 : %2".arg(assetsRcEnabled).arg(assetsPrefix));
	}

	Component.onCompleted: {
		setGlInfo(OpenGLInfo);
	}
}
