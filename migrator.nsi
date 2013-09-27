; PimpBot Migrator by Jan T. Sott
; This script allows you to tweak your AVS settings

;Header
Caption "PimpBot Migrator"
OutFile migrator.exe
BrandingText "whyEye.org"
InstallDir "$PROGRAMFILES\Winamp"
InstallDirRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Winamp" "UninstallString"
CRCCheck force
SetDatablockOptimize on
RequestExecutionLevel admin
SetCompress force
SetCompressor /SOLID lzma
#ShowInstDetails nevershow
InstallButtonText "Migrate"

;Variables
Var NextButton
Var Settings_Dialog
Var WAini
Var LabelVIS
Var LabelPlugs
Var LabelSkins
Var CheckVIS
Var CheckPlugs
Var CheckSkins
Var CheckUser
Var MigrateVIS
Var MigratePlugs
Var MigrateSkins
Var BrowseVIS
Var BrowsePlugs
Var BrowseSkins
Var VISDir
Var DSPDir
Var SkinDir
Var VisTarget
Var VisState
Var PlugsTarget
Var PlugsState
Var SkinsTarget
Var SkinsState
Var UserState
Var AllPlugs

;Includes
!include "MUI2.nsh"
!include "nsDialogs.nsh"
!include "LogicLib.nsh"
!include "WordFunc.nsh"
!include "FileFunc.nsh"
	!insertmacro "GetSize"
!include "WinMessages.nsh"
	!insertmacro "WordFind"
	
;Definitions
!define COL_REQ "0xfff799"
!define COL_VAL "0xd8eabd"
!define COL_INV "0xffbfbf"

;Pages
Page custom Settings SettingsLeave
!insertmacro MUI_PAGE_INSTFILES

;Languages
LangString Settings ${LANG_ENGLISH} "Settings"
LangString Settings_SubCap ${LANG_ENGLISH} "Choose your Migration Settings below."
!insertmacro MUI_LANGUAGE "English"

;Sections
	Section
		${IfNot} $AllPlugs == "1"		
			${IfNot} $VISTarget == ""
			${AndIf} $VISState == "1"
				ClearErrors
				${If} ${FileExists} "$VISDir\vis_*.*"
					CopyFiles /SILENT "$VISDir\vis_*.*" "$VISTarget"
				${EndIf}
				
				${If} ${FileExists} "$VISDir\avs\*.*"
					SetOutPath "$VISDir\avs"
					CopyFiles /SILENT "$VISDir\avs" "$VISTarget\avs"
				${EndIf}
				
				${If} ${FileExists} "$VISDir\MilkDrop\*.*"
					SetOutPath "$VISDir\MilkDrop"
					CopyFiles /SILENT  "$VISDir\MilkDrop" "$VISTarget\MilkDrop"
				${EndIf}
				
				${If} ${FileExists} "$VISDir\MilkDrop2\*.*"
					SetOutPath "$VISDir\MilkDrop2"
					CopyFiles /SILENT "$VISDir\MilkDrop2" "$VISTarget\MilkDrop2"
				${EndIf}
				
				${If} ${Errors}
					DetailPrint "Error copying to $VISTarget"
				${Else}
					Delete "$VISDir\vis_*.*"
					RMDir /r "$VISDir\avs"
					RMDir /r "$VISDir\MilkDrop"
					RMDir /r "$VISDir\MilkDrop2"
				${EndIf}
				WriteINIStr "$WAini" "Winamp" "VISDir" "$VISTarget"
			${EndIf}
			
			${IfNot} $PlugsTarget == ""
			${AndIf} $PlugsState == "1"
				ClearErrors
				
				!macro CopyPlugs PlugName
					${If} ${FileExists} "${PlugName}"
						CopyFiles /SILENT "${PlugName}" "$PlugsTarget"
					${EndIf}
				!macroend
				!define CopyPlug "!insertmacro CopyPlugs"
				
				${If} ${FileExists} "$DSPDir\DSP_SPS\*.*"
					SetOutPath "$PlugsTarget\DSP_SPS"
					CopyFiles /SILENT "$DSPDir\DSP_SPS\*.*" "$PlugsTarget\DSP_SPS"
				${EndIf}
				
				/*
				${If} ${FileExists} "$DSPDir\freeform\*.*"
					SetOutPath "$PlugsTarget\freeform"
					CopyFiles /SILENT "$DSPDir\freeform\*.*" "$PlugsTarget\freeform"
				${EndIf}
				
				${If} ${FileExists} "$DSPDir\Gracenote\*.*"
					SetOutPath "$PlugsTarget\Gracenote"
					CopyFiles /SILENT "$DSPDir\Gracenote\*.*" "$PlugsTarget\Gracenote"
				${EndIf}
				
				${If} ${FileExists} "$DSPDir\ml\*.*"
					SetOutPath "$PlugsTarget\ml"
					CopyFiles /SILENT "$DSPDir\ml\*.*" "$PlugsTarget\ml"
				${EndIf}
				*/
				
				${CopyPlug} "$DSPDir\dsp_*.*"
				#${CopyPlug} "$DSPDir\enc_*.*"
				#${CopyPlug} "$DSPDir\gen*.*"
				#${CopyPlug} "$DSPDir\in_*.*"
				#${CopyPlug} "$DSPDir\ml_*.*"
				#${CopyPlug} "$DSPDir\out_*.*"
				#${CopyPlug} "$DSPDir\pmp_*.*"
				#${CopyPlug} "$DSPDir\lame_enc.dll"
				#${CopyPlug} "$DSPDir\nsvdec_vp3.dll"
				#${CopyPlug} "$DSPDir\nsvdec_vp5.dll"
				#${CopyPlug} "$DSPDir\read_file.dll"
				#${CopyPlug} "$DSPDir\ReplayGainAnalysis.dll"
				#${CopyPlug} "$DSPDir\tataki.dll"
				#${CopyPlug} "$DSPDir\winampFLV.swf"
				
				
				${If} ${Errors}
					DetailPrint "Error copying to $PlugsTarget"
				${Else}
					Delete "$DSPDir\dsp_*.*"
					#Delete "$DSPDir\enc_*.*"
					#Delete "$DSPDir\gen_*.*"
					#Delete "$DSPDir\in_*.*"
					#Delete "$DSPDir\ml_*.*"
					#Delete "$DSPDir\out_*.*"
					#Delete "$DSPDir\pmp_*.*"
					#Delete "$DSPDir\lame_enc.dll"
					#Delete "$DSPDir\nsvdec_vp3.dll"
					#Delete "$DSPDir\nsvdec_vp5.dll"
					#Delete "$DSPDir\read_file.dll"
					#Delete "$DSPDir\ReplayGainAnalysis.dll"
					#Delete "$DSPDir\tataki.dll"
					#Delete "$DSPDir\winampFLV.swf"
					RMDir /r "$DSPDir\DSP_SPS"
					#RMDir /r "$DSPDir\freeform"
					#RMDir /r "$DSPDir\Gracenote"
					#RMDir /r "$DSPDir\ml"
				${EndIf}
				WriteINIStr "$WAini" "Winamp" "DSPDir" "$PlugsTarget"
			${EndIf}
		${Else}
			ClearErrors
			CopyFiles /SILENT "$DSPDir" "$PlugsTarget"
			WriteINIStr "$WAini" "Winamp" "VISDir" "$VISTarget"
			WriteINIStr "$WAini" "Winamp" "DSPDir" "$PlugsTarget"
			
			${If} ${Errors}
					DetailPrint "Error copying to $PlugsTarget"
			${Else}
				RMDir /R "$DSPDir"
			${EndIf}
		${EndIf}
		
		${IfNot} $SkinsTarget == ""
		${AndIf} $SkinsState == "1"
			ClearErrors
			${If} ${FileExists} "$SkinDir\*.*"
				CopyFiles /SILENT "$SkinDir\*.*" "$SkinsTarget"
			${EndIf}
			
			${If} ${Errors}
				DetailPrint "Error copying to $SkinsTarget"
			${Else}
				RMDir /r "$SkinDir"
			${EndIf}
			WriteINIStr "$WAini" "Winamp" "SkinDir" "$SkinsTarget"
		${EndIf}
		
		${If} $UserState == "1"
			WriteINIStr "$INSTDIR\paths.ini" "Winamp" "inidir" "{26}\Winamp"
			${If} ${FileExists} "$INSTDIR\Winamp.ini"
				CopyFiles /SILENT "$INSTDIR\Winamp.ini" "$APPDATA\Winamp\Winamp.ini"
			${EndIf}	
		${EndIf}
	SectionEnd

;Functions
Function .onInit ;detects Winamp.ini
	${If} ${FileExists} "$INSTDIR\paths.ini"
		ReadINIStr $0 "$INSTDIR\paths.ini" "Winamp" "inidir"
		${If} $0 == "{26}\Winamp"
			StrCpy $WAini "$APPDATA\Winamp\Winamp.ini"
		${ElseIf} ${FileExists} "$0\Winamp.ini"
			StrCpy $WAini "$0\Winamp.ini"
		${EndIf}
	${Else}
		StrCpy $WAini "$INSTDIR\Winamp.ini"
	${EndIf}
	
	${If} ${FileExists} "$SMPROGRAMS\whyEye.org\PimpBot\*.*"
		${If} ${FileExists} "$SMPROGRAMS\whyEye.org\PimpBot\Tools\Compile Migrator.lnk"
			Delete "$SMPROGRAMS\whyEye.org\PimpBot\Tools\Compile Migrator.lnk"
		${EndIf}
		
		${IfNot} ${FileExists} "$SMPROGRAMS\whyEye.org\PimpBot\Tools\Migrator.lnk"
				CreateShortCut "$SMPROGRAMS\whyEye.org\PimpBot\Tools\Migrator.lnk" "$EXEDIR\migrator.exe"
		${EndIf}
	${EndIf}
FunctionEnd

	Function Settings
	
		!insertmacro MUI_HEADER_TEXT "$(Settings)" "$(Settings_SubCap)"
		nsDialogs::Create /NOUNLOAD 1018
		
		Pop $Settings_Dialog

		${If} $Settings_Dialog == error
			Abort
		${EndIf}
		
		LockWindow on
		
		GetDlgItem $NextButton $HWNDPARENT 1 ; next=1, cancel=2, back=3
		EnableWindow $NextButton 0

		;VISDir=C:\%BLA%\Plugins
		ReadINIStr $VISDir "$WAini" "Winamp" "VISDir"
		${If} $VISDir == ""
			StrCpy $VISDir "$INSTDIR\Plugins"
		${EndIf}
		
		; --VIS--
		${NSD_CreateLabel} 0 10 100% 12u "Move visualization plugins from $VISDir to:" ;x y width height text
		Pop $LabelVIS
		
		${NSD_CreateCheckBox} 0 30 12u 12u " " ;x y width height text
		Pop $CheckVIS
		${NSD_OnClick} $CheckVIS onClick_Checks
		
		${NSD_CreateDirRequest} 12u 30 400 12u "$APPDATA\Winamp\Plugins" ;x y width height text
		Pop $MigrateVIS
		GetFunctionAddress $0 OnChange_Dirs
		nsDialogs::OnChange /NOUNLOAD $MigrateVIS $0
		EnableWindow $MigrateVIS 0
		
		${NSD_CreateBrowseButton} 420 30 28 12u "..."
		Pop $BrowseVIS
		GetFunctionAddress $0 OnClick_VIS
		nsDialogs::OnClick /NOUNLOAD $BrowseVIS $0
		EnableWindow $BrowseVIS 0
		
		;DSPDir=C:\%BLA%\Plugins
		ReadINIStr $DSPDir "$WAini" "Winamp" "DSPDir"
		${If} $DSPDir == ""
			StrCpy $DSPDir "$INSTDIR\Plugins"
		${EndIf}

		; --PLUGS--
		${NSD_CreateLabel} 0 75 100% 12u "Move DSP plugins from $DSPDir to:" ;x y width height text
		Pop $LabelPlugs
		
		${NSD_CreateCheckBox} 0 95 12u 12u " " ;x y width height text
		Pop $CheckPlugs
		${NSD_OnClick} $CheckPlugs onClick_Checks
		
		${NSD_CreateDirRequest} 12u 95 400 12u "$APPDATA\Winamp\Plugins" ;x y width height text
		Pop $MigratePlugs
		GetFunctionAddress $0 OnChange_Dirs
		nsDialogs::OnChange /NOUNLOAD $MigratePlugs $0
		EnableWindow $MigratePlugs 0
		
		${NSD_CreateBrowseButton} 420 95 28 12u "..."
		Pop $BrowsePlugs
		GetFunctionAddress $0 OnClick_Plugs
		nsDialogs::OnClick /NOUNLOAD $BrowsePlugs $0
		EnableWindow $BrowsePlugs 0
		
		;SkinDir=C:\%BLA%\Skins
		ReadINIStr $SkinDir "$WAini" "Winamp" "SkinDir"
		${If} $SkinDir == ""
			StrCpy $SkinDir "$INSTDIR\Skins"
		${EndIf}			
		
		; --SKINS--
		${NSD_CreateLabel} 0 140 100% 12u "Move skins from $SkinDir to:" ;x y width height text
		Pop $LabelSkins
		
		${NSD_CreateCheckBox} 0 160 12u 12u " " ;x y width height text
		Pop $CheckSkins
		${NSD_OnClick} $CheckSkins onClick_Checks
		
		${NSD_CreateDirRequest} 12u 160 400 12u "$APPDATA\Winamp\Skins" ;x y width height text
		Pop $MigrateSkins
		GetFunctionAddress $0 OnChange_Dirs
		nsDialogs::OnChange /NOUNLOAD $MigrateSkins $0
		EnableWindow $MigrateSkins 0
		
		${NSD_CreateBrowseButton} 420 160 28 12u "..."
		Pop $BrowseSkins
		GetFunctionAddress $0 OnClick_Skins
		nsDialogs::OnClick /NOUNLOAD $BrowseSkins $0
		EnableWindow $BrowseSkins 0	
		
		${NSD_CreateCheckBox} 0 200 100% 12u "Migrate User Settings" ;x y width height text
		Pop $CheckUser
		${NSD_OnClick} $CheckUser onClick_Checks
		
		nsDialogs::Show
	FunctionEnd
	
	Function onClick_Checks
		${NSD_GetState} $CheckPlugs $0
		${NSD_GetState} $CheckSkins $1
		${NSD_GetState} $CheckVis $2
		${NSD_GetState} $CheckUser $3
		
		${If} $0 == "0"
			EnableWindow $MigratePlugs 0
			EnableWindow $BrowsePlugs 0
			SetCtlColors $MigratePlugs "" ""
		${ElseIf} $0 == "1"
			EnableWindow $MigratePlugs 1
			EnableWindow $BrowsePlugs 1
		${EndIf}
		
		${If} $1 == "0"
			EnableWindow $MigrateSkins 0
			EnableWindow $BrowseSkins 0
			SetCtlColors $MigrateSkins "" ""
		${ElseIf} $1 == "1"
			EnableWindow $MigrateSkins 1
			EnableWindow $BrowseSkins 1
		${EndIf}
		
		${If} $2 == "0"
			EnableWindow $MigrateVIS 0
			EnableWindow $BrowseVIS 0
			SetCtlColors $MigrateVIS "" ""
		${ElseIf} $2 == "1"
			EnableWindow $MigrateVIS 1
			EnableWindow $BrowseVIS 1
		${EndIf}
		
		IntOp $4 $0 + $1
		IntOp $4 $4 + $2
		IntOp $4 $4 + $3
		
		${If} $4 == "0"
			EnableWindow $NextButton 0
		${Else}
			EnableWindow $NextButton 1
		${EndIf}
		
		Call OnChange_Dirs

	FunctionEnd
	
	Function OnChange_Dirs
		${NSD_GetState} $CheckPlugs $0
		${NSD_GetText} $MigratePlugs $R0
		${NSD_GetState} $CheckSkins $1
		${NSD_GetText} $MigrateSkins $R1
		${NSD_GetState} $CheckVIS $2
		${NSD_GetText} $MigrateVIS $R2
		
		${If} $0 == "1"		
			${If} ${FileExists} "$R0\*.*"
				SetCtlColors $MigratePlugs "" ${COL_VAL}
				EnableWindow $NextButton 1
			${Else}
				SetCtlColors $MigratePlugs "" ${COL_INV}
				EnableWindow $NextButton 0
			${EndIf}			
		${Else}
			SetCtlColors $MigratePlugs "" ""
		${EndIf}
		
		${If} $1 == "1"
			${If} ${FileExists} "$R1\*.*"
				SetCtlColors $MigrateSkins "" ${COL_VAL}
				EnableWindow $NextButton 1
			${Else}
				SetCtlColors $MigrateSkins "" ${COL_INV}
				EnableWindow $NextButton 0
			${EndIf}
		${Else}
			SetCtlColors $MigrateSkins "" ""
		${EndIf}
		
		${If} $2 == "1"
			${If} ${FileExists} "$R2\*.*"
				SetCtlColors $MigrateVIS "" ${COL_VAL}
				EnableWindow $NextButton 1
			${Else}
				SetCtlColors $MigrateVIS "" ${COL_INV}
				EnableWindow $NextButton 0
			${EndIf}
		${Else}
			SetCtlColors $MigrateVIS "" ""
		${EndIf}
		
		LockWindow off
	FunctionEnd

	Function OnClick_Plugs
		${NSD_GetState} $CheckPlugs $1
		${If} $1 == "1"
			${IfNot} ${FileExists} "$APPDATA\Winamp\Plugins\*.*"
				CreateDirectory "$APPDATA\Winamp\Plugins\"
			${EndIf}
			
			nsDialogs::SelectFolderDialog /NOUNLOAD "Please select a target directory" "$APPDATA\Winamp\Plugins"
			Pop $0
			${If} $0 == error
				Abort
			${EndIf}
			SendMessage $MigratePlugs ${WM_SETTEXT} 0 "STR:$0"
		${EndIf}
	FunctionEnd
	
	Function OnClick_Skins
		${NSD_GetState} $CheckSkins $1
		${If} $1 == "1"
			${IfNot} ${FileExists} "$APPDATA\Winamp\Skins\*.*"
				CreateDirectory "$APPDATA\Winamp\Skins\"
			${EndIf}
			nsDialogs::SelectFolderDialog /NOUNLOAD "Please select a target directory" "$APPDATA\Winamp\Skins"
			Pop $0
			${If} $0 == error
				Abort
			${EndIf}
			SendMessage $MigrateSkins ${WM_SETTEXT} 0 "STR:$0"
		${EndIf}
	FunctionEnd
	
	Function OnClick_VIS
		${NSD_GetState} $CheckVIS $1
		${If} $1 == "1"
			${IfNot} ${FileExists} "$APPDATA\Winamp\Plugins\*.*"
				CreateDirectory "$APPDATA\Winamp\Plugins\"
			${EndIf}
			nsDialogs::SelectFolderDialog /NOUNLOAD "Please select a target directory" "$APPDATA\Winamp\Plugins"
			Pop $0
			${If} $0 == error
				Abort
			${EndIf}
			SendMessage $MigrateVIS ${WM_SETTEXT} 0 "STR:$0"
		${EndIf}
	FunctionEnd
	
	
	Function SettingsLeave
	/*
		${NSD_GetText} $MigrateSkins $MigrateSkins
		${GetSize} "$MigrateSkins" "/S=0K" $1 $2 $3
		MessageBox MB_OK "$MigrateSkins = $1"
	*/
		${NSD_GetState} $CheckVIS $VisState
		${NSD_GetState} $CheckPlugs $PlugsState
		${NSD_GetState} $CheckSkins $SkinsState
		${NSD_GetState} $CheckUser $UserState
		
		${NSD_GetText} $MigrateVIS $VISTarget
		${NSD_GetText} $MigratePlugs $PlugsTarget
		${NSD_GetText} $MigrateSkins $SkinsTarget

		${If} $VISTarget == $VISDIR
		${AndIf} $VisState == "1"
			MessageBox MB_OK|MB_ICONEXCLAMATION "Source and target for visualizations are the same."
			Abort
		${EndIf}
		
		${If} $PlugsTarget == $DSPDIR
		${AndIf} $PlugsState == "1"
			MessageBox MB_OK|MB_ICONEXCLAMATION "Source and target for plugins are the same."
			Abort
		${EndIf}
		
		${If} $SkinsTarget == $SKINDIR
		${AndIf} $SkinsState == "1"
			MessageBox MB_OK|MB_ICONEXCLAMATION "Source and target for skins are the same."
			Abort
		${EndIf}
		
		IntOp $0 $VisState + $PlugsState
		${If} $0 == "1"
			MessageBox MB_YESNO|MB_ICONINFORMATION "For better reliability it is recommended to migrate all plugins. Do you want to reconsider?" IDNO +3
		    StrCpy $AllPlugs "1"
			Abort
		${EndIf}		

		${If} $VisState == "1"
			${IfNot} ${FileExists} "$VISTarget"
				MessageBox MB_YESNO|MB_ICONQUESTION "Visualizations-directory does not exist, create it?" IDYES +2
				Abort
				CreateDirectory "$VISTarget"
			${EndIf}
		${Else}
			StrCpy $MigrateVIS ""
		${EndIf}
		
		#${NSD_GetState} $CheckPlugs $CheckPlugs
		${If} $PlugsState == "1"			
			${IfNot} ${FileExists} "$PlugsTarget"
				MessageBox MB_YESNO|MB_ICONQUESTION "Plugins-directory does not exist, create it?" IDYES +2
				Abort
				CreateDirectory "$PlugsTarget"
			${EndIf}
		${Else}
			StrCpy $MigratePlugs ""
		${EndIf}
				
		${If} $SkinsState == "1"			
			${IfNot} ${FileExists} "$SkinsTarget"
				MessageBox MB_YESNO|MB_ICONQUESTION "Skins-directory does not exist, create it?" IDYES +2
				Abort
				CreateDirectory "$SkinsTarget"
			${EndIf}
		${Else}
			StrCpy $MigrateSkins ""
		${EndIf}
	FunctionEnd