﻿'#########################################################
'#  frmOptions.bas                                       #
'#  This file is part of VisualFBEditor                  #
'#  Authors: Xusinboy Bekchanov (bxusinboy@mail.ru)      #
'#           Liu XiaLin (LiuZiQi.HK@hotmail.com)         #
'#########################################################

#include once "frmOptions.bi"
#include once "TabWindow.bi"

Dim Shared Languages As WStringList
Dim Shared fOptions As frmOptions
pfOptions = @fOptions

'#Region "Form"
	Constructor frmOptions
		' Form1
		This.Name = "frmOptions"
		This.Text = ML("Options")
		This.OnCreate = @Form_Create
		This.OnClose = @Form_Close
		This.OnShow = @Form_Show
		This.MinimizeBox = False
		This.MaximizeBox = False
		This.SetBounds 0, 0, 630, 488
		This.StartPosition = FormStartPosition.CenterParent
		This.Caption = ML("Options")
		This.CancelButton = @cmdCancel
		This.DefaultButton = @cmdOK
		This.BorderStyle = FormBorderStyle.FixedDialog
		' tvOptions
		tvOptions.Name = "tvOptions"
		tvOptions.Text = "TreeView1"
		tvOptions.SetBounds 10, 6, 178, 400
		tvOptions.HideSelection = False
		tvOptions.OnSelChanged = @TreeView1_SelChange
		tvOptions.Parent = @This
		' cmdOK
		cmdOK.Name = "cmdOK"
		cmdOK.Text = ML("OK")
		cmdOK.Default = True
		cmdOK.SetBounds 348, 427, 90, 24
		cmdOK.OnClick = @cmdOK_Click
		cmdOK.Caption = ML("OK")
		cmdOK.Parent = @This
		' cmdCancel
		cmdCancel.Name = "cmdCancel"
		cmdCancel.Text = ML("Cancel")
		cmdCancel.SetBounds 437, 427, 90, 24
		cmdCancel.OnClick = @cmdCancel_Click
		cmdCancel.Parent = @This
		' cmdApply
		cmdApply.Name = "cmdApply"
		cmdApply.Text = ML("Apply")
		cmdApply.SetBounds 526, 427, 90, 24
		cmdApply.OnClick = @cmdApply_Click
		cmdApply.Parent = @This
		' lblBlack
		lblBlack.Name = "lblBlack"
		lblBlack.Text = ""
		lblBlack.BorderStyle = 2
		lblBlack.BackColor = 8421504
		lblBlack.SetBounds 11, 419, 606, 1
		lblBlack.Parent = @This
		' lblWhite
		lblWhite.Name = "lblWhite"
		lblWhite.Text = ""
		lblWhite.BackColor = 16777215
		lblWhite.SetBounds 11, 420, 606, 1
		lblWhite.Parent = @This
		' pnlGeneral
		pnlGeneral.Name = "pnlGeneral"
		pnlGeneral.Text = ""
		pnlGeneral.SetBounds 190, 10, 426, 400
		pnlGeneral.Parent = @This
		' pnlCodeEditor
		pnlCodeEditor.Name = "pnlCodeEditor"
		pnlCodeEditor.Text = ""
		pnlCodeEditor.SetBounds 190, 10, 426, 400
		pnlCodeEditor.Parent = @This
		' pnlColorsAndFonts
		pnlColorsAndFonts.Name = "pnlColorsAndFonts"
		pnlColorsAndFonts.Text = ""
		pnlColorsAndFonts.SetBounds 190, 2, 426, 400
		pnlColorsAndFonts.Parent = @This
		' pnlCompiler
		pnlCompiler.Name = "pnlCompiler"
		pnlCompiler.Text = ""
		pnlCompiler.SetBounds 190, 10, 426, 400
		pnlCompiler.Parent = @This
		' pnlMake
		pnlMake.Name = "pnlMake"
		pnlMake.Text = ""
		pnlMake.SetBounds 190, 10, 426, 400
		pnlMake.Parent = @This
		' pnlDebugger
		pnlDebugger.Name = "pnlDebugger"
		pnlDebugger.Text = ""
		pnlDebugger.SetBounds 190, 2, 426, 408
		pnlDebugger.Parent = @This
		' pnlTerminal
		pnlTerminal.Name = "pnlTerminal"
		pnlTerminal.Text = ""
		pnlTerminal.SetBounds 190, 10, 426, 400
		pnlTerminal.Parent = @This
		' pnlDesigner
		pnlDesigner.Name = "pnlDesigner"
		pnlDesigner.Text = ""
		pnlDesigner.SetBounds 190, 10, 426, 400
		pnlDesigner.Parent = @This
		' pnlLocalization
		pnlLocalization.Name = "pnlLocalization"
		pnlLocalization.Text = ""
		pnlLocalization.SetBounds 190, 2, 426, 400
		pnlLocalization.Parent = @This
		' pnlThemes
		pnlThemes.Name = "pnlThemes"
		pnlThemes.Text = ""
		pnlThemes.SetBounds 190, 2, 426, 408
		pnlThemes.Parent = @This
		' pnlShortcuts
		pnlShortcuts.Name = "pnlShortcuts"
		pnlShortcuts.Text = ""
		pnlShortcuts.SetBounds 190, 2, 426, 408
		pnlShortcuts.Parent = @This
		' pnlHelp
		pnlHelp.Name = "pnlHelp"
		pnlHelp.Text = ""
		pnlHelp.SetBounds 190, 2, 426, 400
		pnlHelp.Parent = @This
		' grbDefaultCompilers
		With grbDefaultCompilers
			.Name = "grbDefaultCompilers"
			.Text = ML("Default Compilers")
			.SetBounds 10, -2, 416, 128
			.Parent = @pnlCompiler
		End With
		' grbShortcuts
		With grbShortcuts
			.Name = "grbShortcuts"
			.Text = ML("Shortcuts")
			.SetBounds 10, 6, 416, 400
			.Parent = @pnlShortcuts
		End With
		' grbCompilerPaths
		With grbCompilerPaths
			.Name = "grbCompilerPaths"
			.Text = ML("Compiler Paths")
			.SetBounds 10, 134, 416, 264
			.Parent = @pnlCompiler
		End With
		' lblShortcut
		lblShortcut.Name = "lblShortcut"
		lblShortcut.Text = ML("Select shortcut") & ":"
		lblShortcut.SetBounds 18, 369, 132, 18
		lblShortcut.Parent = @grbShortcuts
		' hkShortcut
		hkShortcut.Name = "hkShortcut"
		hkShortcut.SetBounds 146, 367, 199, 19
		hkShortcut.Parent = @grbShortcuts
		' cmdSetShortcut
		cmdSetShortcut.Name = "cmdSetShortcut"
		cmdSetShortcut.Text = ML("Set")
		cmdSetShortcut.SetBounds 354, 366, 52, 21
		cmdSetShortcut.OnClick = @cmdSetShortcut_Click
		cmdSetShortcut.Parent = @grbShortcuts
		' lvShortcuts
		With lvShortcuts
			.Name = "lvShortcuts"
			.Text = "lvShortcuts"
			.SetBounds 18, 22, 384, 333
			.OnSelectedItemChanged = @lvShortcuts_SelectedItemChanged
			.Parent = @grbShortcuts
		End With
		' lblCompiler32
		lblCompiler32.Name = "lblCompiler32"
		lblCompiler32.Text = ML("Compiler") & " " & ML("32-bit")
		lblCompiler32.SetBounds 18, 24, 260, 18
		lblCompiler32.Parent = @grbDefaultCompilers
		' lblCompiler64
		lblCompiler64.Name = "lblCompiler64"
		lblCompiler64.Text = ML("Compiler") & " " & ML("64-bit")
		lblCompiler64.SetBounds 18, 74, 266, 18
		lblCompiler64.Parent = @grbDefaultCompilers
		' grbDefaultDebugger
		With grbDefaultDebugger
			.Name = "grbDefaultDebugger"
			.Text = ML("Default Debugger")
			.SetBounds 10, 6, 416, 64
			.Parent = @pnlDebugger
		End With
		' grbDebuggerPaths
		With grbDebuggerPaths
			.Name = "grbDebuggerPaths"
			.Text = ML("Debugger Paths")
			.SetBounds 10, 78, 416, 328
			.Parent = @pnlDebugger
		End With
		' cboDebugger
		With cboDebugger
			.Name = "cboDebugger"
			.Text = "cboCompiler321"
			.SetBounds 18, 24, 384, 21
			.Parent = @grbDefaultDebugger
		End With
		' grbDefaultTerminal
		With grbDefaultTerminal
			.Name = "grbDefaultTerminal"
			.Text = ML("Default Terminal")
			.SetBounds 10, -2, 416, 64
			.Parent = @pnlTerminal
		End With
		' cboTerminal
		With cboTerminal
			.Name = "cboTerminal"
			.Text = "cboTerminal"
			.SetBounds 18, 24, 384, 21
			.Parent = @grbDefaultTerminal
		End With
		' grbTerminalPaths
		With grbTerminalPaths
			.Name = "grbTerminalPaths"
			.Text = ML("Terminal Paths")
			.SetBounds 10, 70, 416, 328
			.Parent = @pnlTerminal
		End With
		' lvTerminalPath
		With lvTerminalPaths
			.Name = "lvTerminalPaths"
			.Text = "lvTerminalPaths"
			.SetBounds 18, 22, 384, 256
			.Parent = @grbTerminalPaths
		End With
		' cmdAddTerminal
		With cmdAddTerminal
			.Name = "cmdAddTerminal"
			.Text = ML("&Add")
			.SetBounds 17, 289, 96, 24
			.OnClick = @cmdAddTerminal_Click
			.Parent = @grbTerminalPaths
		End With
		' cmdRemoveTerminal
		With cmdRemoveTerminal
			.Name = "cmdRemoveTerminal"
			.Text = ML("&Remove")
			.SetBounds 211, 289, 96, 24
			.OnClick = @cmdRemoveTerminal_Click
			.Parent = @grbTerminalPaths
		End With
		' cmdClearDebuggers1
		With cmdClearTerminals
			.Name = "cmdClearTerminals"
			.Text = ML("&Clear")
			.SetBounds 307, 289, 96, 24
			.OnClick = @cmdClearTerminals_Click
			.Parent = @grbTerminalPaths
		End With
		' grbLanguage
		With grbLanguage
			.Name = "grbLanguage"
			.Text = ML("Language")
			.SetBounds 8, 6, 414, 395
			.Parent = @pnlLocalization
		End With
		' grbThemes
		With grbThemes
			.Name = "grbThemes"
			.Text = ML("Themes")
			.SetBounds 8, 7, 414, 394
			.Parent = @pnlThemes
		End With
		' cboLanguage
		cboLanguage.Name = "cboLanguage"
		'ComboBoxEdit1.Text = "russian"
		cboLanguage.SetBounds 10, 20, 392, 21
		cboLanguage.Parent = @grbLanguage
		' cmdAddCompiler
		cmdAddCompiler.Name = "cmdAddCompiler"
		cmdAddCompiler.Text = ML("&Add")
		cmdAddCompiler.SetBounds 17, 224, 96, 24
		cmdAddCompiler.OnClick = @cmdAddCompiler_Click
		cmdAddCompiler.Parent = @grbCompilerPaths
		' CheckBox1
		CheckBox1.Name = "CheckBox1"
		CheckBox1.Text = ML("Auto increment version")
		CheckBox1.SetBounds 10, 0, 318, 18
		CheckBox1.Parent = @pnlGeneral
		' chkAutoCreateRC
		chkAutoCreateRC.Name = "chkAutoCreateRC"
		chkAutoCreateRC.Text = ML("Auto create resource and manifest files (.rc, .xml)")
		chkAutoCreateRC.SetBounds 10, 22, 300, 18
		chkAutoCreateRC.Parent = @pnlGeneral
		' pnlIncludes
		pnlIncludes.Name = "pnlIncludes"
		pnlIncludes.SetBounds 190, 6, 426, 408
		pnlIncludes.Text = ""
		pnlIncludes.Parent = @This
		' grbIncludePaths
		With grbIncludePaths
			.Name = "grbIncludePaths"
			.Text = ML("Include Paths")
			.SetBounds 10, 3, 416, 216
			.Parent = @pnlIncludes
		End With
		' grbLibraryPaths
		With grbLibraryPaths
			.Name = "grbLibraryPaths"
			.Text = ML("Library Paths")
			.SetBounds 10, 230, 416, 168
			.Parent = @pnlIncludes
		End With
		' txtMFFpath
		txtMFFpath.Name = "txtMFFpath"
		txtMFFpath.SetBounds 160, 21, 217, 20
		txtMFFpath.Parent = @grbIncludePaths
		' cmdMFFPath
		cmdMFFPath.Name = "cmdMFFPath"
		cmdMFFPath.Text = "..."
		cmdMFFPath.SetBounds 377, 20, 24, 22
		cmdMFFPath.OnClick = @cmdMFFPath_Click
		cmdMFFPath.Parent = @grbIncludePaths
		' chkEnableAutoComplete
		chkEnableAutoComplete.Name = "chkEnableAutoComplete"
		chkEnableAutoComplete.Text = ML("Enable Auto Complete")
		chkEnableAutoComplete.SetBounds 10, 21, 264, 18
		chkEnableAutoComplete.Parent = @pnlCodeEditor
		' chkTabAsSpaces
		chkTabAsSpaces.Name = "chkTabAsSpaces"
		chkTabAsSpaces.Text = ML("Treat Tab as Spaces")
		chkTabAsSpaces.SetBounds 10, 135, 264, 18
		chkTabAsSpaces.Parent = @pnlCodeEditor
		' chkAutoIndentation
		chkAutoIndentation.Name = "chkAutoIndentation"
		chkAutoIndentation.Text = ML("Auto Indentation")
		chkAutoIndentation.SetBounds 10, 0, 264, 18
		chkAutoIndentation.Parent = @pnlCodeEditor
		' lblTabSize
		lblTabSize.Name = "lblTabSize"
		lblTabSize.Text = ML("Tab Size") & ":"
		lblTabSize.SetBounds 66, 183, 138, 16
		lblTabSize.Parent = @pnlCodeEditor
		' txtTabSize
		txtTabSize.Name = "txtTabSize"
		txtTabSize.Text = ""
		txtTabSize.SetBounds 209, 181, 90, 20
		txtTabSize.Parent = @pnlCodeEditor
		' chkShowSpaces
		chkShowSpaces.Name = "chkShowSpaces"
		chkShowSpaces.Text = ML("Show Spaces")
		chkShowSpaces.SetBounds 10, 43, 264, 18
		chkShowSpaces.Parent = @pnlCodeEditor
		' lstIncludePaths
		lstIncludePaths.Name = "lstIncludePaths"
		lstIncludePaths.Text = "ListControl1"
		lstIncludePaths.SetBounds 16, 68, 360, 134
		lstIncludePaths.Parent = @grbIncludePaths
		' lstLibraryPaths
		lstLibraryPaths.Name = "lstLibraryPaths"
		lstLibraryPaths.Text = "ListControl11"
		lstLibraryPaths.SetBounds 16, 22, 360, 132
		lstLibraryPaths.Parent = @grbLibraryPaths
		' lblOthers
		lblOthers.Name = "lblOthers"
		lblOthers.Text = ML("Others") & ":"
		lblOthers.SetBounds 16, 48, 138, 18
		lblOthers.Parent = @grbIncludePaths
		' cmdAddInclude
		cmdAddInclude.Name = "cmdAddInclude"
		cmdAddInclude.Text = "+"
		cmdAddInclude.SetBounds 376, 67, 24, 22
		cmdAddInclude.OnClick = @cmdAddInclude_Click
		cmdAddInclude.Parent = @grbIncludePaths
		' cmdRemoveInclude
		cmdRemoveInclude.Name = "cmdRemoveInclude"
		cmdRemoveInclude.Text = "-"
		cmdRemoveInclude.SetBounds 376, 88, 24, 22
		cmdRemoveInclude.OnClick = @cmdRemoveInclude_Click
		cmdRemoveInclude.Parent = @grbIncludePaths
		' cmdAddLibrary
		cmdAddLibrary.Name = "cmdAddLibrary"
		cmdAddLibrary.Text = "+"
		cmdAddLibrary.SetBounds 376, 21, 24, 22
		cmdAddLibrary.OnClick = @cmdAddLibrary_Click
		cmdAddLibrary.Parent = @grbLibraryPaths
		' cmdRemoveLibrary
		cmdRemoveLibrary.Name = "cmdRemoveLibrary"
		cmdRemoveLibrary.Text = "-"
		cmdRemoveLibrary.SetBounds 376, 42, 24, 22
		cmdRemoveLibrary.OnClick = @cmdRemoveLibrary_Click
		cmdRemoveLibrary.Parent = @grbLibraryPaths
		' cmdChangeDebugger
		cmdChangeDebugger.Name = "cmdChangeDebugger"
		cmdChangeDebugger.Text = ML("Chan&ge")
		cmdChangeDebugger.SetBounds 114, 289, 96, 24
		cmdChangeDebugger.OnClick = @cmdChangeDebugger_Click
		cmdChangeDebugger.Parent = @grbDebuggerPaths
		' cmdChangeTerminal
		cmdChangeTerminal.Name = "cmdChangeTerminal"
		cmdChangeTerminal.Text = ML("Chan&ge")
		cmdChangeTerminal.SetBounds 114, 289, 96, 24
		cmdChangeTerminal.Parent = @grbTerminalPaths
		' lblHistoryLimit
		lblHistoryLimit.Name = "lblHistoryLimit"
		lblHistoryLimit.Text = ML("History limit") & ":"
		lblHistoryLimit.SetBounds 66, 206, 150, 17
		lblHistoryLimit.Parent = @pnlCodeEditor
		' txtHistoryLimit
		txtHistoryLimit.Name = "txtHistoryLimit"
		txtHistoryLimit.SetBounds 209, 204, 90, 20
		txtHistoryLimit.Text = ""
		txtHistoryLimit.Parent = @pnlCodeEditor
		' grbGrid
		grbGrid.Name = "grbGrid"
		grbGrid.Text = ML("Grid")
		grbGrid.SetBounds 8, -1, 414, 192
		grbGrid.Parent = @pnlDesigner
		' lblGridSize
		lblGridSize.Name = "lblGridSize"
		lblGridSize.Text = ML("Size") & ":"
		lblGridSize.SetBounds 16, 31, 60, 18
		lblGridSize.Parent = @grbGrid
		' txtGridSize
		txtGridSize.Name = "txtGridSize"
		txtGridSize.Text = "10"
		txtGridSize.SetBounds 73, 31, 114, 18
		txtGridSize.Parent = @grbGrid
		' chkShowAlignmentGrid
		chkShowAlignmentGrid.Name = "chkShowAlignmentGrid"
		chkShowAlignmentGrid.Text = ML("Show Alignment Grid")
		chkShowAlignmentGrid.SetBounds 8, -5, 186, 30
		chkShowAlignmentGrid.Parent = @pnlGrid
		' chkSnapToGrid
		chkSnapToGrid.Name = "chkSnapToGrid"
		chkSnapToGrid.Text = ML("Snap to Grid")
		chkSnapToGrid.SetBounds 8, 19, 138, 24
		chkSnapToGrid.Parent = @pnlGrid
		' cboCase
		cboCase.Name = "cboCase"
		cboCase.Text = "ComboBoxEdit2"
		cboCase.SetBounds 209, 157, 162, 21
		cboCase.Parent = @pnlCodeEditor
		' chkChangeKeywordsCase
		chkChangeKeywordsCase.Name = "chkChangeKeywordsCase"
		chkChangeKeywordsCase.Text = ML("Change Keywords Case To") & ":"
		chkChangeKeywordsCase.SetBounds 10, 158, 194, 18
		chkChangeKeywordsCase.Parent = @pnlCodeEditor
		' cboTabStyle
		cboTabStyle.Name = "cboTabStyle"
		cboTabStyle.Text = "cboCase1"
		cboTabStyle.SetBounds 209, 133, 162, 21
		cboTabStyle.Parent = @pnlCodeEditor
		' grbColors
		grbColors.Name = "grbColors"
		grbColors.Text = ML("Colors")
		grbColors.SetBounds 10, 6, 416, 336
		grbColors.Parent = @pnlColorsAndFonts
		' grbFont
		grbFont.Name = "grbFont"
		grbFont.Text = ML("Font (applies to all styles)")
		grbFont.SetBounds 10, 342, 416, 56
		grbFont.Parent = @pnlColorsAndFonts
		' grbMakeToolPaths
		With grbMakeToolPaths
			.Name = "grbMakeToolPaths"
			.Text = ML("Make Tool Paths")
			.SetBounds 10, 70, 416, 328
			.Parent = @pnlMake
		End With
		' lvMakeToolPaths
		With lvMakeToolPaths
			.Name = "lvMakeToolPaths"
			.Text = "lvMakeToolPaths"
			.SetBounds 18, 22, 384, 256
			.Parent = @grbMakeToolPaths
		End With
		' cmdAddMakeTool
		With cmdAddMakeTool
			.Name = "cmdAddMakeTool"
			.Text = ML("&Add")
			.SetBounds 17, 289, 96, 24
			.OnClick = @cmdAddMakeTool_Click
			.IsChild = True
			.ID = 1010
			.Parent = @grbMakeToolPaths
		End With
		' cmdRemoveMakeTool
		With cmdRemoveMakeTool
			.Name = "cmdRemoveMakeTool"
			.Text = ML("&Remove")
			.SetBounds 211, 289, 96, 24
			.OnClick = @cmdRemoveMakeTool_Click
			.Parent = @grbMakeToolPaths
		End With
		' cmdClearMakeTool
		With cmdClearMakeTools
			.Name = "cmdClearMakeTools"
			.Text = ML("&Clear")
			.SetBounds 307, 289, 96, 24
			.OnClick = @cmdClearMakeTools_Click
			.Parent = @grbMakeToolPaths
		End With
		' grbDefaultMakeTool
		With grbDefaultMakeTool
			.Name = "grbDefaultMakeTool"
			.Text = ML("Default Make Tool")
			.SetBounds 10, -2, 416, 64
			.Parent = @pnlMake
		End With
		' cboMakeTool
		With cboMakeTool
			.Name = "cboMakeTool"
			.Text = "cboMakeTool"
			.SetBounds 18, 24, 384, 21
			.Parent = @grbDefaultMakeTool
		End With
		' cmdChangeMakeTool
		cmdChangeMakeTool.Name = "cmdChangeMakeTool"
		cmdChangeMakeTool.Text = ML("Chan&ge")
		cmdChangeMakeTool.SetBounds 114, 289, 96, 24
		cmdChangeMakeTool.OnClick = @cmdChangeMakeTool_Click
		cmdChangeMakeTool.Parent = @grbMakeToolPaths
		' cboTheme
		cboTheme.Name = "cboTheme"
		cboTheme.Text = "ComboBoxEdit2"
		cboTheme.SetBounds 18, 20, 224, 21
		cboTheme.OnChange = @cboTheme_Change
		cboTheme.Parent = @grbColors
		' lstColorKeys
		lstColorKeys.Name = "lstColorKeys"
		lstColorKeys.Text = "ListControl1"
		lstColorKeys.SetBounds 18, 55, 224, 264
		lstColorKeys.OnChange = @lstColorKeys_Change
		lstColorKeys.Parent = @grbColors
		' cmdAdd
		cmdAdd.Name = "cmdAdd"
		cmdAdd.Text = ML("&Add")
		cmdAdd.SetBounds 258, 20, 71, 23
		cmdAdd.OnClick = @cmdAdd_Click
		cmdAdd.Parent = @grbColors
		' cmdRemove
		cmdRemove.Name = "cmdRemove"
		cmdRemove.Text = ML("&Remove")
		cmdRemove.SetBounds 330, 20, 71, 23
		cmdRemove.OnClick = @cmdRemove_Click
		cmdRemove.Parent = @grbColors
		' lblColorForeground
		lblColorForeground.Name = "lblColorForeground"
		lblColorForeground.Text = ""
		lblColorForeground.SetBounds 258, 71, 72, 20
		lblColorForeground.BackColor = 0
		lblColorForeground.Parent = @grbColors
		' cmdForeground
		cmdForeground.Name = "cmdForeground"
		cmdForeground.Text = "..."
		cmdForeground.SetBounds 330, 70, 24, 22
		cmdForeground.Caption = "..."
		cmdForeground.OnClick = @cmdForeground_Click
		cmdForeground.Parent = @grbColors
		' cmdFont
		cmdFont.Name = "cmdFont"
		cmdFont.Text = "..."
		cmdFont.SetBounds 376, 18, 24, 22
		cmdFont.Caption = "..."
		cmdFont.OnClick = @cmdFont_Click
		cmdFont.Parent = @grbFont
		' lblFont
		lblFont.Name = "lblFont"
		lblFont.Text = ML("Font")
		lblFont.SetBounds 23, 23, 344, 16
		lblFont.Parent = @grbFont
		' txtProjectsPath
		txtProjectsPath.Name = "txtProjectsPath"
		txtProjectsPath.Text = "./Projects"
		txtProjectsPath.SetBounds 10, 368, 390, 20
		txtProjectsPath.Parent = @pnlGeneral
		' cmdProjectsPath
		cmdProjectsPath.Name = "cmdProjectsPath"
		cmdProjectsPath.Text = "..."
		cmdProjectsPath.SetBounds 400, 367, 24, 22
		cmdProjectsPath.Caption = "..."
		cmdProjectsPath.OnClick = @cmdProjectsPath_Click
		cmdProjectsPath.Parent = @pnlGeneral
		' lblProjectsPath
		lblProjectsPath.Name = "lblProjectsPath"
		lblProjectsPath.Text = ML("Projects path") & ":"
		lblProjectsPath.SetBounds 13, 350, 96, 16
		lblProjectsPath.Parent = @pnlGeneral
		' lblColorBackground
		lblColorBackground.Name = "lblColorBackground"
		lblColorBackground.SetBounds 258, 113, 72, 20
		lblColorBackground.BackColor = 0
		lblColorBackground.Text = ""
		lblColorBackground.Parent = @grbColors
		' cmdBackground
		cmdBackground.Name = "cmdBackground"
		cmdBackground.Text = "..."
		cmdBackground.SetBounds 330, 112, 24, 22
		cmdBackground.Caption = "..."
		cmdBackground.OnClick = @cmdBackground_Click
		cmdBackground.Parent = @grbColors
		' lblForeground
		lblForeground.Name = "lblForeground"
		lblForeground.Text = ML("Foreground") & ":"
		lblForeground.SetBounds 258, 55, 136, 16
		lblForeground.Parent = @grbColors
		' lblBackground
		lblBackground.Name = "lblBackground"
		lblBackground.Text = ML("Background") & ":"
		lblBackground.SetBounds 258, 96, 136, 16
		lblBackground.Parent = @grbColors
		' lblIndicator
		lblIndicator.Name = "lblIndicator"
		lblIndicator.Text = ML("Indicator") & ":"
		lblIndicator.SetBounds 258, 176, 136, 16
		lblIndicator.Parent = @grbColors
		' lblColorIndicator
		lblColorIndicator.Name = "lblColorIndicator"
		lblColorIndicator.Text = ""
		lblColorIndicator.SetBounds 258, 192, 72, 20
		lblColorIndicator.BackColor = 0
		lblColorIndicator.Parent = @grbColors
		' cmdIndicator
		cmdIndicator.Name = "cmdIndicator"
		cmdIndicator.Text = "..."
		cmdIndicator.SetBounds 330, 191, 24, 22
		cmdIndicator.Caption = "..."
		cmdIndicator.OnClick = @cmdIndicator_Click
		cmdIndicator.Parent = @grbColors
		'
		' chkForeground
		chkForeground.Name = "chkForeground"
		chkForeground.Text = ML("Auto")
		chkForeground.SetBounds 0, 9, 48, 16
		chkForeground.OnClick = @chkForeground_Click
		chkForeground.Parent = @pnlColors
		' chkBackground
		chkBackground.Name = "chkBackground"
		chkBackground.Text = ML("Auto")
		chkBackground.SetBounds 0, 51, 48, 16
		chkBackground.OnClick = @chkBackground_Click
		chkBackground.Parent = @pnlColors
		' chkIndicator
		chkIndicator.Name = "chkIndicator"
		chkIndicator.Text = ML("Auto")
		chkIndicator.SetBounds 0, 130, 48, 16
		chkIndicator.OnClick = @chkIndicator_Click
		chkIndicator.Parent = @pnlColors
		' chkBold
		chkBold.Name = "chkBold"
		chkBold.Text = ML("Bold")
		chkBold.SetBounds 268, 251, 107, 16
		chkBold.OnClick = @chkBold_Click
		chkBold.Parent = @pnlColorsAndFonts
		' chkItalic
		chkItalic.Name = "chkItalic"
		chkItalic.Text = ML("Italic")
		chkItalic.SetBounds 268, 275, 99, 16
		chkItalic.OnClick = @chkItalic_Click
		chkItalic.Parent = @pnlColorsAndFonts
		' chkUnderline
		chkUnderline.Name = "chkUnderline"
		chkUnderline.Text = ML("Underline")
		chkUnderline.SetBounds 268, 299, 107, 16
		chkUnderline.OnClick = @chkUnderline_Click
		chkUnderline.Parent = @pnlColorsAndFonts
		' chkUseMakeOnStartWithCompile
		chkUseMakeOnStartWithCompile.Name = "chkUseMakeOnStartWithCompile"
		chkUseMakeOnStartWithCompile.Text = ML("Use make on start with compile (if exists makefile)")
		chkUseMakeOnStartWithCompile.SetBounds 10, 93, 400, 16
		chkUseMakeOnStartWithCompile.Caption = ML("Use make on start with compile (if exists makefile)")
		chkUseMakeOnStartWithCompile.Parent = @pnlGeneral
		' lvCompilerPaths
		With lvCompilerPaths
			.Name = "lvCompilerPaths"
			.Text = "ListView1"
			.SetBounds 18, 24, 384, 192
			.Parent = @grbCompilerPaths
		End With
		' cboCompiler32
		With cboCompiler32
			.Name = "cboCompiler32"
			.Text = "ComboBoxEdit2"
			.SetBounds 18, 40, 384, 21
			.Parent = @grbDefaultCompilers
		End With
		' cboCompiler64
		With cboCompiler64
			.Name = "cboCompiler64"
			.Text = "ComboBoxEdit21"
			.SetBounds 18, 90, 384, 21
			.Parent = @grbDefaultCompilers
		End With
		' cmdRemoveCompiler
		With cmdRemoveCompiler
			.Name = "cmdRemoveCompiler"
			.Text = ML("&Remove")
			.SetBounds 211, 224, 96, 24
			.OnClick = @cmdRemoveCompiler_Click
			.Parent = @grbCompilerPaths
		End With
		' cmdClearCompilers
		With cmdClearCompilers
			.Name = "cmdClearCompilers"
			.Text = ML("&Clear")
			.SetBounds 308, 224, 96, 24
			.OnClick = @cmdClearCompilers_Click
			.Parent = @grbCompilerPaths
		End With
		' lvDebuggerPaths
		With lvDebuggerPaths
			.Name = "lvDebuggerPaths"
			.Text = "lvCompilerPaths1"
			.SetBounds 18, 22, 384, 256
			.Parent = @grbDebuggerPaths
		End With
		' cmdAddDebugger
		With cmdAddDebugger
			.Name = "cmdAddDebugger"
			.Text = ML("&Add")
			.SetBounds 17, 289, 96, 24
			.OnClick = @cmdAddDebugger_Click
			.Parent = @grbDebuggerPaths
		End With
		' cmdRemoveDebugger
		With cmdRemoveDebugger
			.Name = "cmdRemoveDebugger"
			.Text = ML("&Remove")
			.SetBounds 211, 289, 96, 24
			.OnClick = @cmdRemoveDebugger_Click
			.Parent = @grbDebuggerPaths
		End With
		' cmdClearDebuggers
		With cmdClearDebuggers
			.Name = "cmdClearDebuggers"
			.Text = ML("&Clear")
			.SetBounds 307, 289, 96, 24
			.OnClick = @cmdClearDebuggers_Click
			.Parent = @grbDebuggerPaths
		End With
		' lblInterfaceFont
		With lblInterfaceFont
			.Name = "lblInterfaceFont"
			.Text = "Tahoma, 8 pt"
			.SetBounds 107, 20, 264, 16
			.Caption = "Tahoma, 8 pt"
			.Parent = @grbThemes
		End With
		' cmdInterfaceFont
		With cmdInterfaceFont
			.Name = "cmdInterfaceFont"
			.Text = "..."
			.SetBounds 376, 20, 24, 22
			.Caption = "..."
			.OnClick = @cmdInterfaceFont_Click
			.Parent = @grbThemes
		End With
		' lblInterfaceFontLabel
		With lblInterfaceFontLabel
			.Name = "lblInterfaceFontLabel"
			.Text = ML("Interface font") & ":"
			.SetBounds 10, 20, 80, 16
			.Parent = @grbThemes
		End With
		' chkDisplayIcons
		With chkDisplayIcons
			.Name = "chkDisplayIcons"
			.Text = ML("Display Icons in the Menu")
			.SetBounds 2, 1, 216, 16
			.Parent = @pnlThemesCheckboxes
		End With
		' chkShowMainToolbar
		With chkShowMainToolbar
			.Name = "chkShowMainToolbar"
			.Text = ML("Show main Toolbar")
			.SetBounds 2, 18, 224, 24
			.Parent = @pnlThemesCheckboxes
		End With
		' chkAutoReloadLastOpenSources
		With chkAutoReloadLastOpenSources
			.Name = "chkAutoReloadLastOpenSources"
			.Text = ML("Auto-reload last open sources")
			.SetBounds 10, 47, 400, 16
			.Parent = @pnlGeneral
		End With
		' chkAutoCreateBakFiles
		With chkAutoCreateBakFiles
			.Name = "chkAutoCreateBakFiles"
			.Text = ML("Auto create bak files before saving")
			.SetBounds 10, 70, 400, 16
			.ID = 1009
			.Parent = @pnlGeneral
		End With
		' lblFrame
		With lblFrame
			.Name = "lblFrame"
			.Text = ML("Frame") & ":"
			.SetBounds 258, 136, 136, 16
			.Parent = @grbColors
		End With
		' lblColorFrame
		With lblColorFrame
			.Name = "lblColorFrame"
			.SetBounds 258, 152, 72, 20
			.BackColor = 0
			.Parent = @grbColors
		End With
		' cmdFrame
		With cmdFrame
			.Name = "cmdFrame"
			.Text = "..."
			.SetBounds 330, 151, 24, 22
			.Caption = "..."
			.OnClick = @cmdFrame_Click
			.Parent = @grbColors
		End With
		' chkFrame
		With chkFrame
			.Name = "chkFrame"
			.Text = ML("Auto")
			.SetBounds 0, 90, 48, 16
			.OnClick = @chkFrame_Click
			.Parent = @pnlColors
		End With
		' chkHighlightCurrentWord
		With chkHighlightCurrentWord
			.Name = "chkHighlightCurrentWord"
			.Text = ML("Highlight Current Word")
			.SetBounds 10, 84, 192, 26
			.Parent = @pnlCodeEditor
		End With
		' chkHighlightCurrentLine
		With chkHighlightCurrentLine
			.Name = "chkHighlightCurrentLine"
			.Text = ML("Highlight Current Line")
			.SetBounds 10, 66, 224, 16
			.Parent = @pnlCodeEditor
		End With
		' chkHighlightBrackets
		With chkHighlightBrackets
			.Name = "chkHighlightBrackets"
			.Text = ML("Highlight Brackets")
			.SetBounds 10, 111, 154, 18
			.Parent = @pnlCodeEditor
		End With
		' cmdChangeCompiler
		With cmdChangeCompiler
			.Name = "cmdChangeCompiler"
			.Text = ML("Chan&ge")
			.SetBounds 114, 224, 96, 24
			.OnClick = @cmdChangeCompiler_Click
			.Parent = @grbCompilerPaths
		End With
		' grbDefaultHelp
		With grbDefaultHelp
			.Name = "grbDefaultHelp"
			.Text = ML("Default Help")
			.SetBounds 10, 6, 416, 64
			.Parent = @pnlHelp
		End With
		' cboHelp
		With cboHelp
			.Name = "cboHelp"
			.Text = "cboHelp"
			.SetBounds 18, 24, 384, 21
			.Parent = @grbDefaultHelp
		End With
		' grbHelpPaths
		With grbHelpPaths
			.Name = "grbHelpPaths"
			.Text = ML("Help Paths")
			.SetBounds 10, 78, 416, 323
			.Parent = @pnlHelp
		End With
		' lvHelpPaths
		With lvHelpPaths
			.Name = "lvHelpPaths"
			.Text = "lvTerminalPaths1"
			.SetBounds 18, 22, 384, 256
			.Parent = @grbHelpPaths
		End With
		' cmdAddHelp
		With cmdAddHelp
			.Name = "cmdAddHelp"
			.Text = ML("&Add")
			.SetBounds 17, 288, 96, 24
			.OnClick = @cmdAddHelp_Click
			.Parent = @grbHelpPaths
		End With
		' cmdChangeHelp
		With cmdChangeHelp
			.Name = "cmdChangeHelp"
			.Text = ML("Chan&ge")
			.SetBounds 114, 288, 96, 24
			.OnClick = @cmdChangeHelp_Click
			.Parent = @grbHelpPaths
		End With
		' cmdRemoveHelp
		With cmdRemoveHelp
			.Name = "cmdRemoveHelp"
			.Text = ML("&Remove")
			.SetBounds 211, 288, 96, 24
			.OnClick = @cmdRemoveHelp_Click
			.Parent = @grbHelpPaths
		End With
		' cmdClearHelp
		With cmdClearHelps
			.Name = "cmdClearHelps"
			.Text = ML("&Clear")
			.SetBounds 307, 289, 96, 24
			.OnClick = @cmdClearHelps_Click
			.Parent = @grbHelpPaths
		End With
		' grbWhenCompiling
		With grbWhenCompiling
			.Name = "grbWhenCompiling"
			.Text = ML("When compiling") & ":"
			.SetBounds 8, 160, 416, 104
			.Parent = @pnlGeneral
		End With
		' optSaveCurrentFile
		With optSaveCurrentFile
			.Name = "optSaveCurrentFile"
			.Text = ML("Save Current File")
			.SetBounds 18, 22, 184, 16
			.Parent = @grbWhenCompiling
		End With
		' optDoNotSave
		With optDoNotSave
			.Name = "optDoNotSave"
			.Text = ML("Don't Save")
			.SetBounds 18, 70, 184, 16
			.Parent = @grbWhenCompiling
		End With
		' optSaveAllFiles
		With optSaveAllFiles
			.Name = "optSaveAllFiles"
			.Text = ML("Save All Files")
			.SetBounds 18, 46, 184, 16
			.Parent = @grbWhenCompiling
		End With
		' Panel1
		With Panel1
			.Name = "Panel1"
			.Text = "Panel1"
			.SetBounds 8, 23, 152, 16
			.Parent = @grbIncludePaths
		End With
		' chkIncludeMFFPath
		With chkIncludeMFFPath
			.Name = "chkIncludeMFFPath"
			.Text = ML("Include MFF Path") & ":"
			.SetBounds 7, 0, 150, 18
			.Parent = @Panel1
		End With
		' pnlThemesCheckboxes
		With pnlThemesCheckboxes
			.Name = "pnlThemesCheckboxes"
			.Text = "Panel2"
			.SetBounds 10, 63, 320, 48
			.Parent = @grbThemes
		End With
		' pnlColors
		With pnlColors
			.Name = "pnlColors"
			.Text = "Panel2"
			.SetBounds 360, 64, 40, 160
			.Parent = @grbColors
		End With
		' pnlGrid
		With pnlGrid
			.Name = "pnlGrid"
			.Text = "Panel2"
			.SetBounds 10, 63, 314, 106
			.Parent = @grbGrid
		End With
		' chkLimitDebug
		With chkLimitDebug
			.Name = "chkLimitDebug"
			.Text = ML("Limit debug to the directory of the main file")
			.SetBounds 10, 116, 400, 16
			.Parent = @pnlGeneral
		End With
		' chkDisplayWarningsInDebug
		With chkDisplayWarningsInDebug
			.Name = "chkDisplayWarningsInDebug"
			.Text = ML("Display warnings in debug")
			.SetBounds 10, 138, 400, 16
			.Parent = @pnlGeneral
		End With
	End Constructor
	
	Destructor frmOptions
		WDeallocate InterfFontName
		WDeallocate OldInterfFontName
		WDeallocate EditFontName
	End Destructor
	
	#ifndef _NOT_AUTORUN_FORMS_
		fOptions.Show
		
		App.Run
	#endif
'#End Region

Private Sub frmOptions.cmdOK_Click(ByRef Sender As Control)
	cmdApply_Click(Sender)
	Cast(frmOptions Ptr, Sender.Parent)->CloseForm
End Sub

Private Sub frmOptions.cmdCancel_Click(ByRef Sender As Control)
	Cast(frmOptions Ptr, Sender.Parent)->CloseForm
End Sub

Sub frmOptions.LoadSettings()
	With fOptions
		.chkTabAsSpaces.Checked = TabAsSpaces
		.cboTabStyle.ItemIndex = ChoosedTabStyle
		.cboCase.ItemIndex = ChoosedKeyWordsCase
		.chkChangeKeywordsCase.Checked = ChangeKeywordsCase
		.chkUseMakeOnStartWithCompile.Checked = UseMakeOnStartWithCompile
		.chkLimitDebug.Checked = LimitDebug
		.txtTabSize.Text = Str(TabWidth)
		.txtHistoryLimit.Text = Str(HistoryLimit)
		.txtMFFPath.Text = *MFFPath
		.chkIncludeMFFPath.Checked = IncludeMFFPath
		.txtProjectsPath.Text = *ProjectsPath
		.CheckBox1.Checked = AutoIncrement
		.chkEnableAutoComplete.Checked = AutoComplete
		.chkAutoIndentation.Checked = AutoIndentation
		.chkAutoCreateRC.Checked = AutoCreateRC
		.chkAutoCreateBakFiles.Checked = AutoCreateBakFiles
		.chkAutoReloadLastOpenSources.Checked = AutoReloadLastOpenFiles
		Select Case AutoSaveBeforeCompiling
		Case 0: .optDoNotSave.Checked = True
		Case 1: .optSaveCurrentFile.Checked = True
		Case 2: .optSaveAllFiles.Checked = True
		End Select
		.chkShowSpaces.Checked = ShowSpaces
		.chkHighlightBrackets.Checked = HighlightBrackets
		.chkHighlightCurrentLine.Checked = HighlightCurrentLine
		.chkHighlightCurrentWord.Checked = HighlightCurrentWord
		.txtGridSize.Text = Str(GridSize)
		.chkShowAlignmentGrid.Checked = ShowAlignmentGrid
		.chkSnapToGrid.Checked = SnapToGridOption
		.cboLanguage.Clear
		.chkDisplayIcons.Checked = DisplayMenuIcons
		.chkShowMainToolbar.Checked = ShowMainToolbar
		Dim As String f
		Dim As Integer Fn = FreeFile, Result
		Dim Buff As WString * 2048 '
		Dim As UString FileName
		'On Error Resume Next
		f = Dir(ExePath & "/Settings/Languages/*.lng")
		While f <> ""
			FileName = ExePath & "/Settings/Languages/" & f
			Result = Open(FileName For Input Encoding "utf-8" As #Fn)
			If Result <> 0 Then Result = Open(FileName For Input Encoding "utf-16" As #Fn)
			If Result <> 0 Then Result = Open(FileName For Input Encoding "utf-32" As #Fn)
			If Result <> 0 Then Result = Open(FileName For Input As #Fn)
			If Result = 0 Then
				'WReallocate s, LOF(Fn) '
				If Not EOF(Fn) Then
					Line Input #Fn, Buff  '
					Languages.Add Left(f, Len(f) - 4)
					.cboLanguage.AddItem Buff & " - " & Left(f, Len(f) - 4)
				End If
				Close #Fn
			Else
				Languages.Add Left(f, Len(f) - 4)
				.cboLanguage.AddItem Left(f, Len(f) - 4) & " (" & ML("format does not match") & ")"
			End If
			f = Dir()
		Wend
		HotKeysChanged = False 
		'On Error Goto 0
		'WDeallocate s '
		newIndex = Languages.IndexOf(CurLanguage)
		.cboLanguage.ItemIndex = newIndex
		oldIndex = newIndex
		.cboTheme.Clear
		f = Dir(ExePath & "/Settings/Themes/*.ini")
		While f <> ""
			.cboTheme.AddItem Left(f, Len(f) - 4)
			f = Dir()
		Wend
		.cboTheme.ItemIndex = .cboTheme.IndexOf(*CurrentTheme)
		.cboCompiler32.Clear
		.cboCompiler64.Clear
		.lvCompilerPaths.ListItems.Clear
		.cboCompiler32.AddItem ML("(not selected)")
		.cboCompiler64.AddItem ML("(not selected)")
		For i As Integer = 0 To pCompilers->Count - 1
			.lvCompilerPaths.ListItems.Add pCompilers->Item(i)->Key
			.lvCompilerPaths.ListItems.Item(i)->Text(1) = pCompilers->Item(i)->Text
			.cboCompiler32.AddItem pCompilers->Item(i)->Key
			.cboCompiler64.AddItem pCompilers->Item(i)->Key
		Next
		.cboCompiler32.ItemIndex = Max(0, .cboCompiler32.IndexOf(*DefaultCompiler32))
		.cboCompiler64.ItemIndex = Max(0, .cboCompiler64.IndexOf(*DefaultCompiler64))
		.cboMakeTool.Clear
		.lvMakeToolPaths.ListItems.Clear
		.cboMakeTool.AddItem ML("(not selected)")
		For i As Integer = 0 To pMakeTools->Count - 1
			.lvMakeToolPaths.ListItems.Add pMakeTools->Item(i)->Key
			.lvMakeToolPaths.ListItems.Item(i)->Text(1) = pMakeTools->Item(i)->Text
			.cboMakeTool.AddItem pMakeTools->Item(i)->Key
		Next
		.cboMakeTool.ItemIndex = Max(0, .cboMakeTool.IndexOf(*DefaultMakeTool))
		.cboDebugger.Clear
		.lvDebuggerPaths.ListItems.Clear
		.cboDebugger.AddItem ML("Integrated IDE Debugger")
		For i As Integer = 0 To pDebuggers->Count - 1
			.lvDebuggerPaths.ListItems.Add pDebuggers->Item(i)->Key
			.lvDebuggerPaths.ListItems.Item(i)->Text(1) = pDebuggers->Item(i)->Text
			.cboDebugger.AddItem pDebuggers->Item(i)->Key
		Next
		.cboDebugger.ItemIndex = Max(0, .cboDebugger.IndexOf(*DefaultDebugger))
		.cboTerminal.Clear
		.lvTerminalPaths.ListItems.Clear
		.cboTerminal.AddItem ML("(not selected)")
		For i As Integer = 0 To pTerminals->Count - 1
			.lvTerminalPaths.ListItems.Add pTerminals->Item(i)->Key
			.lvTerminalPaths.ListItems.Item(i)->Text(1) = pTerminals->Item(i)->Text
			.cboTerminal.AddItem pTerminals->Item(i)->Key
		Next
		.cboTerminal.ItemIndex = Max(0, .cboTerminal.IndexOf(*DefaultTerminal))
		.cboHelp.Clear
		.lvHelpPaths.ListItems.Clear
		.cboHelp.AddItem ML("(not selected)")
		For i As Integer = 0 To pHelps->Count - 1
			.lvHelpPaths.ListItems.Add pHelps->Item(i)->Key
			.lvHelpPaths.ListItems.Item(i)->Text(1) = pHelps->Item(i)->Text
			.cboHelp.AddItem pHelps->Item(i)->Key
		Next
		.cboHelp.ItemIndex = Max(0, .cboHelp.IndexOf(*DefaultHelp))
		.lstIncludePaths.Clear
		For i As Integer = 0 To pIncludePaths->Count - 1
			.lstIncludePaths.AddItem pIncludePaths->Item(i)
		Next
		.lstLibraryPaths.Clear
		For i As Integer = 0 To pLibraryPaths->Count - 1
			.lstLibraryPaths.AddItem pLibraryPaths->Item(i)
		Next
		For i As Integer = 0 To 15
			For j As Integer = 0 To 6
				.Colors(i, j) = -2
			Next
		Next
		.Colors(0, 0) = Bookmarks.Foreground
		.Colors(0, 1) = Bookmarks.Background
		.Colors(0, 2) = Bookmarks.Frame
		.Colors(0, 3) = Bookmarks.Indicator
		.Colors(0, 4) = Bookmarks.Bold
		.Colors(0, 5) = Bookmarks.Italic
		.Colors(0, 6) = Bookmarks.Underline
		.Colors(1, 0) = Breakpoints.Foreground
		.Colors(1, 1) = Breakpoints.Background
		.Colors(1, 2) = Breakpoints.Frame
		.Colors(1, 3) = Breakpoints.Indicator
		.Colors(1, 4) = Breakpoints.Bold
		.Colors(1, 5) = Breakpoints.Italic
		.Colors(1, 6) = Breakpoints.Underline
		.Colors(2, 0) = Comments.Foreground
		.Colors(2, 1) = Comments.Background
		.Colors(2, 2) = Comments.Frame
		.Colors(2, 4) = Comments.Bold
		.Colors(2, 5) = Comments.Italic
		.Colors(2, 6) = Comments.Underline
		.Colors(3, 0) = CurrentBrackets.Foreground
		.Colors(3, 1) = CurrentBrackets.Background
		.Colors(3, 2) = CurrentBrackets.Frame
		.Colors(3, 4) = CurrentBrackets.Bold
		.Colors(3, 5) = CurrentBrackets.Italic
		.Colors(3, 6) = CurrentBrackets.Underline
		.Colors(4, 0) = CurrentLine.Foreground
		.Colors(4, 1) = CurrentLine.Background
		.Colors(4, 2) = CurrentLine.Frame
		.Colors(5, 0) = CurrentWord.Foreground
		.Colors(5, 1) = CurrentWord.Background
		.Colors(5, 2) = CurrentWord.Frame
		.Colors(5, 4) = CurrentWord.Bold
		.Colors(5, 5) = CurrentWord.Italic
		.Colors(5, 6) = CurrentWord.Underline
		.Colors(6, 0) = ExecutionLine.Foreground
		.Colors(6, 1) = ExecutionLine.Background
		.Colors(6, 2) = ExecutionLine.Frame
		.Colors(6, 3) = ExecutionLine.Indicator
		.Colors(7, 0) = FoldLines.Foreground
		.Colors(8, 0) = IndicatorLines.Foreground
		.Colors(9, 0) = Keywords.Foreground
		.Colors(9, 1) = Keywords.Background
		.Colors(9, 2) = Keywords.Frame
		.Colors(9, 4) = Keywords.Bold
		.Colors(9, 5) = Keywords.Italic
		.Colors(9, 6) = Keywords.Underline
		.Colors(10, 0) = LineNumbers.Foreground
		.Colors(10, 1) = LineNumbers.Background
		.Colors(10, 4) = LineNumbers.Bold
		.Colors(10, 5) = LineNumbers.Italic
		.Colors(10, 6) = LineNumbers.Underline
		.Colors(11, 0) = NormalText.Foreground
		.Colors(11, 1) = NormalText.Background
		.Colors(11, 2) = NormalText.Frame
		.Colors(11, 4) = NormalText.Bold
		.Colors(11, 5) = NormalText.Italic
		.Colors(11, 6) = NormalText.Underline
		.Colors(12, 0) = Preprocessors.Foreground
		.Colors(12, 1) = Preprocessors.Background
		.Colors(12, 2) = Preprocessors.Frame
		.Colors(12, 4) = Preprocessors.Bold
		.Colors(12, 5) = Preprocessors.Italic
		.Colors(12, 6) = Preprocessors.Underline
		.Colors(13, 0) = Selection.Foreground
		.Colors(13, 1) = Selection.Background
		.Colors(13, 2) = Selection.Frame
		.Colors(14, 0) = SpaceIdentifiers.Foreground
		.Colors(15, 0) = Strings.Foreground
		.Colors(15, 1) = Strings.Background
		.Colors(15, 2) = Strings.Frame
		.Colors(15, 4) = Strings.Bold
		.Colors(15, 5) = Strings.Italic
		.Colors(15, 6) = Strings.Underline
		.lstColorKeys.ItemIndex = 0
		.lstColorKeys_Change(.lstColorKeys)
		WLet .EditFontName, *EditorFontName
		.EditFontSize = EditorFontSize
		.lblFont.Font.Name = *EditorFontName
		.lblFont.Caption = *.EditFontName & ", " & .EditFontSize & "pt"
		WLet .InterfFontName, *InterfaceFontName
		WLet .OldInterfFontName, *InterfaceFontName
		.InterfFontSize = InterfaceFontSize
		.oldInterfFontSize = InterfaceFontSize
		.oldDisplayMenuIcons = DisplayMenuIcons
		.lblInterfaceFont.Font.Name = *InterfaceFontName
		.lblInterfaceFont.Caption = *.InterfFontName & ", " & .InterfFontSize & "pt"
		.tvOptions.SelectedNode = .tvOptions.Nodes.Item(0)
		.TreeView1_SelChange .tvOptions, *.tvOptions.Nodes.Item(0)
	End With
End Sub

Sub AddShortcuts(item As MenuItem Ptr, ByRef Prefix As WString = "")
	With fOptions
		If StartsWith(item->Name, "Recent") OrElse item->Caption = "-" Then Exit Sub
		Dim As UString itemCaption = Replace(IIf(Prefix = "", "", Prefix & " -> ") & item->Caption, "&", "")
		Dim As UString itemHotKey
		Dim As Integer Pos1 = InStr(itemCaption, !"\t")
		If Pos1 > 0 Then
			itemHotKey = Mid(itemCaption, Pos1 + 1)
			itemCaption = Left(itemCaption, Pos1 - 1)
		End If
		If item->Count = 0 Then
			.HotKeysPriv.Add item->Name
			.lvShortcuts.ListItems.Add itemCaption
			.lvShortcuts.ListItems.Item(.lvShortcuts.ListItems.Count - 1)->Text(1) = itemHotKey
			.lvShortcuts.ListItems.Item(.lvShortcuts.ListItems.Count - 1)->Tag = item
		Else
			For i As Integer = 0 To item->Count - 1
				AddShortcuts item->Item(i), itemCaption
			Next
		End If
	End With
End Sub

Private Sub frmOptions.Form_Create(ByRef Sender As Control)
	With fOptions
		.tvOptions.Nodes.Clear
		Var tnGeneral = .tvOptions.Nodes.Add(ML("General"), "General")
		Var tnEditor = .tvOptions.Nodes.Add(ML("Code Editor"), "CodeEditor")
		Var tnCompiler = .tvOptions.Nodes.Add(ML("Compiler"), "Compiler")
		Var tnDebugger = .tvOptions.Nodes.Add(ML("Debugger"), "Debugger")
		.tvOptions.Nodes.Add(ML("Designer"), "Designer")
		tnGeneral->Nodes.Add(ML("Localization"), "Localization")
		tnGeneral->Nodes.Add(ML("Shortcuts"), "Shortcuts")
		tnGeneral->Nodes.Add(ML("Themes"), "Themes")
		tnEditor->Nodes.Add(ML("Colors And Fonts"), "ColorsAndFonts")
		tnCompiler->Nodes.Add(ML("Includes"), "Includes")
		tnCompiler->Nodes.Add(ML("Make Tool"), "MakeTool")
		tnDebugger->Nodes.Add(ML("Terminal"), "Terminal")
		.tvOptions.Nodes.Add(ML("Help"), "Help")
		.tvOptions.ExpandAll
		.lvShortcuts.Columns.Add ML("Action"), , 250
		.lvShortcuts.Columns.Add ML("Shortcut"), , 100
		.lvCompilerPaths.Columns.Add ML("Version"), , 200
		.lvCompilerPaths.Columns.Add ML("Path"), , 200
		.lvMakeToolPaths.Columns.Add ML("Version"), , 200
		.lvMakeToolPaths.Columns.Add ML("Path"), , 200
		.lvDebuggerPaths.Columns.Add ML("Version"), , 200
		.lvDebuggerPaths.Columns.Add ML("Path"), , 200
		.lvTerminalPaths.Columns.Add ML("Version"), , 200
		.lvTerminalPaths.Columns.Add ML("Path"), , 200
		.lvHelpPaths.Columns.Add ML("Version"), , 200
		.lvHelpPaths.Columns.Add ML("Path"), , 200
		.cboCase.AddItem ML("Original Case")
		.cboCase.AddItem ML("Lower Case")
		.cboCase.AddItem ML("Upper Case")
		.cboTabStyle.AddItem ML("Everywhere")
		.cboTabStyle.AddItem ML("Only after the words")
		.lstColorKeys.AddItem ML("Bookmarks")
		.lstColorKeys.AddItem ML("Breakpoints")
		.lstColorKeys.AddItem ML("Comments")
		.lstColorKeys.AddItem ML("Current Brackets")
		.lstColorKeys.AddItem ML("Current Line")
		.lstColorKeys.AddItem ML("Current Word")
		.lstColorKeys.AddItem ML("Executed Line")
		.lstColorKeys.AddItem ML("Fold Lines")
		.lstColorKeys.AddItem ML("Indicator Lines")
		.lstColorKeys.AddItem ML("Keywords")
		.lstColorKeys.AddItem ML("Line Numbers")
		.lstColorKeys.AddItem ML("Normal Text")
		.lstColorKeys.AddItem ML("Preprocessors")
		.lstColorKeys.AddItem ML("Selection")
		.lstColorKeys.AddItem ML("Space Identifiers")
		.lstColorKeys.AddItem ML("Strings")
		.lstColorKeys.ItemIndex = 0
		For i As Integer = 0 To pfrmMain->Menu->Count - 1
			AddShortcuts(pfrmMain->Menu->Item(i))
		Next
		.LoadSettings
	End With
End Sub

Sub SetColors
	With fOptions
		Bookmarks.ForegroundOption = .Colors(0, 0)
		Bookmarks.BackgroundOption = .Colors(0, 1)
		Bookmarks.FrameOption = .Colors(0, 2)
		Bookmarks.IndicatorOption = .Colors(0, 3)
		Bookmarks.Bold = .Colors(0, 4)
		Bookmarks.Italic = .Colors(0, 5)
		Bookmarks.Underline = .Colors(0, 6)
		Breakpoints.ForegroundOption = .Colors(1, 0)
		Breakpoints.BackgroundOption = .Colors(1, 1)
		Breakpoints.FrameOption = .Colors(1, 2)
		Breakpoints.IndicatorOption = .Colors(1, 3)
		Breakpoints.Bold = .Colors(1, 4)
		Breakpoints.Italic = .Colors(1, 5)
		Breakpoints.Underline = .Colors(1, 6)
		Comments.ForegroundOption = .Colors(2, 0)
		Comments.BackgroundOption = .Colors(2, 1)
		Comments.FrameOption = .Colors(2, 2)
		Comments.Bold = .Colors(2, 4)
		Comments.Italic = .Colors(2, 5)
		Comments.Underline = .Colors(2, 6)
		CurrentBrackets.ForegroundOption = .Colors(3, 0)
		CurrentBrackets.BackgroundOption = .Colors(3, 1)
		CurrentBrackets.FrameOption = .Colors(3, 2)
		CurrentBrackets.Bold = .Colors(3, 4)
		CurrentBrackets.Italic = .Colors(3, 5)
		CurrentBrackets.Underline = .Colors(3, 6)
		CurrentLine.ForegroundOption = .Colors(4, 0)
		CurrentLine.BackgroundOption = .Colors(4, 1)
		CurrentLine.FrameOption = .Colors(4, 2)
		CurrentWord.ForegroundOption = .Colors(5, 0)
		CurrentWord.BackgroundOption = .Colors(5, 1)
		CurrentWord.FrameOption = .Colors(5, 2)
		CurrentWord.Bold = .Colors(5, 4)
		CurrentWord.Italic = .Colors(5, 5)
		CurrentWord.Underline = .Colors(5, 6)
		ExecutionLine.ForegroundOption = .Colors(6, 0)
		ExecutionLine.BackgroundOption = .Colors(6, 1)
		ExecutionLine.FrameOption = .Colors(6, 2)
		ExecutionLine.IndicatorOption = .Colors(6, 3)
		FoldLines.ForegroundOption = .Colors(7, 0)
		IndicatorLines.ForegroundOption = .Colors(8, 0)
		Keywords.ForegroundOption = .Colors(9, 0)
		Keywords.BackgroundOption = .Colors(9, 1)
		Keywords.FrameOption = .Colors(9, 2)
		Keywords.Bold = .Colors(9, 4)
		Keywords.Italic = .Colors(9, 5)
		Keywords.Underline = .Colors(9, 6)
		LineNumbers.ForegroundOption = .Colors(10, 0)
		LineNumbers.BackgroundOption = .Colors(10, 1)
		LineNumbers.Bold = .Colors(10, 4)
		LineNumbers.Italic = .Colors(10, 5)
		LineNumbers.Underline = .Colors(10, 6)
		NormalText.ForegroundOption = .Colors(11, 0)
		NormalText.BackgroundOption = .Colors(11, 1)
		NormalText.FrameOption = .Colors(11, 2)
		NormalText.Bold = .Colors(11, 4)
		NormalText.Italic = .Colors(11, 5)
		NormalText.Underline = .Colors(11, 6)
		Preprocessors.ForegroundOption = .Colors(12, 0)
		Preprocessors.BackgroundOption = .Colors(12, 1)
		Preprocessors.FrameOption = .Colors(12, 2)
		Preprocessors.Bold = .Colors(12, 4)
		Preprocessors.Italic = .Colors(12, 5)
		Preprocessors.Underline = .Colors(12, 6)
		Selection.ForegroundOption = .Colors(13, 0)
		Selection.BackgroundOption = .Colors(13, 1)
		Selection.FrameOption = .Colors(13, 2)
		SpaceIdentifiers.ForegroundOption = .Colors(14, 0)
		Strings.ForegroundOption = .Colors(15, 0)
		Strings.BackgroundOption = .Colors(15, 1)
		Strings.FrameOption = .Colors(15, 2)
		Strings.Bold = .Colors(15, 4)
		Strings.Italic = .Colors(15, 5)
		Strings.Underline = .Colors(15, 6)
		SetAutoColors
	End With
End Sub

Private Sub frmOptions.cmdApply_Click(ByRef Sender As Control)
	On Error Goto ErrorHandler
	With fOptions
		pCompilers->Clear
		Dim As UString tempStr
		For i As Integer = 0 To .lvCompilerPaths.ListItems.Count - 1
			tempStr = .lvCompilerPaths.ListItems.Item(i)->Text(0)
			pCompilers->Add tempStr, .lvCompilerPaths.ListItems.Item(i)->Text(1)
		Next
		WLet DefaultCompiler32, IIf(.cboCompiler32.ItemIndex = 0, "", .cboCompiler32.Text)
		WLet DefaultCompiler64, IIf(.cboCompiler64.ItemIndex = 0, "", .cboCompiler64.Text)
		WLet Compiler32Path, pCompilers->Get(*DefaultCompiler32)
		WLet Compiler64Path, pCompilers->Get(*DefaultCompiler64)
		pMakeTools->Clear
		For i As Integer = 0 To .lvMakeToolPaths.ListItems.Count - 1
			tempStr = .lvMakeToolPaths.ListItems.Item(i)->Text(0)
			pMakeTools->Add tempStr, .lvMakeToolPaths.ListItems.Item(i)->Text(1)
		Next
		WLet DefaultMakeTool, IIf(.cboMakeTool.ItemIndex = 0, "", .cboMakeTool.Text)
		WLet MakeToolPath, pMakeTools->Get(*DefaultMakeTool)
		pDebuggers->Clear
		For i As Integer = 0 To .lvDebuggerPaths.ListItems.Count - 1
			tempStr = .lvDebuggerPaths.ListItems.Item(i)->Text(0)
			pDebuggers->Add tempStr, .lvDebuggerPaths.ListItems.Item(i)->Text(1)
		Next
		WLet DefaultDebugger, IIf(.cboDebugger.ItemIndex = 0, "", .cboDebugger.Text)
		WLet DebuggerPath, pDebuggers->Get(*DefaultDebugger)
		pTerminals->Clear
		For i As Integer = 0 To .lvTerminalPaths.ListItems.Count - 1
			tempStr = .lvTerminalPaths.ListItems.Item(i)->Text(0)
			pTerminals->Add tempStr, .lvTerminalPaths.ListItems.Item(i)->Text(1)
		Next
		WLet DefaultTerminal, IIf(.cboTerminal.ItemIndex = 0, "", .cboTerminal.Text)
		WLet TerminalPath, pTerminals->Get(*DefaultTerminal)
		pHelps->Clear
		miHelps->Clear
		For i As Integer = 0 To .lvHelpPaths.ListItems.Count - 1
			tempStr = .lvHelpPaths.ListItems.Item(i)->Text(0)
			pHelps->Add tempStr, .lvHelpPaths.ListItems.Item(i)->Text(1)
			miHelps->Add(tempStr, .lvHelpPaths.ListItems.Item(i)->Text(1), , @mClickHelp)
		Next
		WLet DefaultHelp, IIf(.cboHelp.ItemIndex = 0, "", .cboHelp.Text)
		WLet HelpPath, pHelps->Get(*DefaultHelp)
		pIncludePaths->Clear
		For i As Integer = 0 To .lstIncludePaths.ItemCount - 1
			pIncludePaths->Add .lstIncludePaths.Item(i)
		Next
		pLibraryPaths->Clear
		For i As Integer = 0 To .lstLibraryPaths.ItemCount - 1
			pLibraryPaths->Add .lstLibraryPaths.Item(i)
		Next
		IncludeMFFPath = .chkIncludeMFFPath.Checked
		WLet MFFPath, .txtMFFPath.Text
		WLet ProjectsPath, .txtProjectsPath.Text
		#ifdef __FB_64BIT__
			WLet MFFDll, *MFFPath & "/mff64.dll"
		#else
			WLet MFFDll, *MFFPath & "/mff32.dll"
		#endif
		TabWidth = Val(.txtTabSize.Text)
		HistoryLimit = Val(.txtHistoryLimit.Text)
		UseMakeOnStartWithCompile = .chkUseMakeOnStartWithCompile.Checked
		LimitDebug = .chkLimitDebug.Checked
		DisplayWarningsInDebug = .chkDisplayWarningsInDebug.Checked
		AutoIncrement = .CheckBox1.Checked
		AutoIndentation = .chkAutoIndentation.Checked
		AutoComplete = .chkEnableAutoComplete.Checked
		AutoCreateRC = .chkAutoCreateRC.Checked
		AutoCreateBakFiles = .chkAutoCreateBakFiles.Checked
		AutoReloadLastOpenFiles = .chkAutoReloadLastOpenSources.Checked
		AutoSaveBeforeCompiling = IIf(.optSaveCurrentFile.Checked, 1, IIf(.optSaveAllFiles.Checked, 2, 0))
		ShowSpaces = .chkShowSpaces.Checked
		HighlightBrackets = .chkHighlightBrackets.Checked
		HighlightCurrentLine = .chkHighlightCurrentLine.Checked
		HighlightCurrentWord = .chkHighlightCurrentWord.Checked
		TabAsSpaces = .chkTabAsSpaces.Checked
		ChoosedTabStyle = .cboTabStyle.ItemIndex
		GridSize = Val(.txtGridSize.Text)
		ShowAlignmentGrid = .chkShowAlignmentGrid.Checked
		SnapToGridOption = .chkSnapToGrid.Checked
		ChangeKeywordsCase = .chkChangeKeywordsCase.Checked
		ChoosedKeywordsCase = .cboCase.ItemIndex
		WLet CurrentTheme, .cboTheme.Text
		WLet EditorFontName, *.EditFontName
		EditorFontSize = .EditFontSize
		WLet InterfaceFontName, *.InterfFontName
		InterfaceFontSize = .InterfFontSize
		DisplayMenuIcons = .chkDisplayIcons.Checked
		ShowMainToolbar = .chkShowMainToolbar.Checked
		SetColors
		If .HotKeysChanged Then
			Dim As Integer Pos1, Fn = FreeFile
			Dim As MenuItem Ptr Item
			Dim As String Key
			Open ExePath & "/Settings/Others/HotKeys.txt" For Output As #Fn
			For i As Integer = 0 To .lvShortcuts.ListItems.Count - 1
				If .HotKeysPriv.Item(i) = "" Then Continue For
				Item = .lvShortcuts.ListItems.Item(i)->Tag
				Pos1 = InStr(Item->Caption, !"\t")
				If Pos1 = 0 Then Pos1 = Len(Item->Caption) + 1
				Key = .lvShortcuts.ListItems.Item(i)->Text(1)
				Item->Caption = Left(Item->Caption, Pos1 - 1) & !"\t" & Key
				Print #Fn, .HotKeysPriv.Item(i) & "=" & Key
			Next
			Close #Fn
			pfrmMain->Menu->ParentWindow = pfrmMain
		End If
		piniSettings->WriteString "Compilers", "DefaultCompiler32", *DefaultCompiler32
		piniSettings->WriteString "Compilers", "DefaultCompiler64", *DefaultCompiler64
		For i As Integer = 0 To Min(9, pCompilers->Count - 1)
			piniSettings->WriteString "Compilers", "Version_" & WStr(i), pCompilers->Item(i)->Key
			piniSettings->WriteString "Compilers", "Path_" & WStr(i), pCompilers->Item(i)->Text
		Next
		For i As Integer = pCompilers->Count To 9
			piniSettings->WriteString "Compilers", "Version_" & WStr(i), ""
			piniSettings->WriteString "Compilers", "Path_" & WStr(i), ""
		Next
		piniSettings->WriteString "MakeTools", "DefaultMakeTool", *DefaultMakeTool
		For i As Integer = 0 To Min(9, pMakeTools->Count - 1)
			piniSettings->WriteString "MakeTools", "Version_" & WStr(i), pMakeTools->Item(i)->Key
			piniSettings->WriteString "MakeTools", "Path_" & WStr(i), pMakeTools->Item(i)->Text
		Next
		For i As Integer = pMakeTools->Count To 9
			piniSettings->WriteString "MakeTools", "Version_" & WStr(i), ""
			piniSettings->WriteString "MakeTools", "Path_" & WStr(i), ""
		Next
		piniSettings->WriteString "Debuggers", "DefaultDebugger", *DefaultDebugger
		For i As Integer = 0 To Min(9, pDebuggers->Count - 1)
			piniSettings->WriteString "Debuggers", "Version_" & WStr(i), pDebuggers->Item(i)->Key
			piniSettings->WriteString "Debuggers", "Path_" & WStr(i), pDebuggers->Item(i)->Text
		Next
		For i As Integer = pDebuggers->Count To 9
			piniSettings->WriteString "Debuggers", "Version_" & WStr(i), ""
			piniSettings->WriteString "Debuggers", "Path_" & WStr(i), ""
		Next
		piniSettings->WriteString "Terminals", "DefaultTerminal", *DefaultTerminal
		For i As Integer = 0 To Min(9, pTerminals->Count - 1)
			piniSettings->WriteString "Terminals", "Version_" & WStr(i), pTerminals->Item(i)->Key
			piniSettings->WriteString "Terminals", "Path_" & WStr(i), pTerminals->Item(i)->Text
		Next
		For i As Integer = pTerminals->Count To 9
			piniSettings->WriteString "Terminals", "Version_" & WStr(i), ""
			piniSettings->WriteString "Terminals", "Path_" & WStr(i), ""
		Next
		piniSettings->WriteString "Helps", "DefaultHelp", *DefaultHelp
		For i As Integer = 0 To Min(9, pHelps->Count - 1)
			piniSettings->WriteString "Helps", "Version_" & WStr(i), pHelps->Item(i)->Key
			piniSettings->WriteString "Helps", "Path_" & WStr(i), pHelps->Item(i)->Text
		Next
		For i As Integer = pHelps->Count To 9
			piniSettings->WriteString "Helps", "Version_" & WStr(i), ""
			piniSettings->WriteString "Helps", "Path_" & WStr(i), ""
		Next
		For i As Integer = 0 To Min(9, pIncludePaths->Count - 1)
			piniSettings->WriteString "IncludePaths", "Path_" & WStr(i), pIncludePaths->Item(i)
		Next
		For i As Integer = pIncludePaths->Count To 9
			piniSettings->WriteString "IncludePaths", "Path_" & WStr(i), ""
		Next
		For i As Integer = 0 To Min(9, pLibraryPaths->Count - 1)
			piniSettings->WriteString "LibraryPaths", "Path_" & WStr(i), pLibraryPaths->Item(i)
		Next
		For i As Integer = pLibraryPaths->Count To 9
			piniSettings->WriteString "LibraryPaths", "Path_" & WStr(i), ""
		Next
		piniSettings->WriteBool "Options", "IncludeMFFPath", IncludeMFFPath
		piniSettings->WriteString "Options", "MFFPath", *MFFPath
		piniSettings->WriteString "Options", "ProjectsPath", *ProjectsPath
		piniSettings->WriteString "Options", "Language", Languages.Item(.cboLanguage.ItemIndex)
		piniSettings->WriteInteger "Options", "TabWidth", TabWidth
		piniSettings->WriteInteger "Options", "HistoryLimit", HistoryLimit
		piniSettings->WriteBool "Options", "UseMakeOnStartWithCompile", UseMakeOnStartWithCompile
		piniSettings->WriteBool "Options", "LimitDebug", LimitDebug
		piniSettings->WriteBool "Options", "DisplayWarningsInDebug", DisplayWarningsInDebug
		piniSettings->WriteBool "Options", "AutoIncrement", AutoIncrement
		piniSettings->WriteBool "Options", "AutoIndentation", AutoIndentation
		piniSettings->WriteBool "Options", "AutoComplete", AutoComplete
		piniSettings->WriteBool "Options", "AutoCreateRC", AutoCreateRC
		piniSettings->WriteBool "Options", "AutoCreateBakFiles", AutoCreateBakFiles
		piniSettings->WriteBool "Options", "AutoReloadLastOpenFiles", AutoReloadLastOpenFiles
		piniSettings->WriteInteger "Options", "AutoSaveBeforeCompiling", AutoSaveBeforeCompiling
		piniSettings->WriteBool "Options", "ShowSpaces", ShowSpaces
		piniSettings->WriteBool "Options", "HighlightBrackets", HighlightBrackets
		piniSettings->WriteBool "Options", "HighlightCurrentLine", HighlightCurrentLine
		piniSettings->WriteBool "Options", "HighlightCurrentWord", HighlightCurrentWord
		piniSettings->WriteBool "Options", "TabAsSpaces", TabAsSpaces
		piniSettings->WriteInteger "Options", "GridSize", GridSize
		piniSettings->WriteBool "Options", "ShowAlignmentGrid", ShowAlignmentGrid
		piniSettings->WriteBool "Options", "SnapToGrid", SnapToGridOption
		piniSettings->WriteBool "Options", "ChangeKeywordsCase", ChangeKeywordsCase
		piniSettings->WriteInteger "Options", "ChoosedKeywordsCase", ChoosedKeywordsCase
		
		piniSettings->WriteString "Options", "CurrentTheme", *CurrentTheme
		
		piniSettings->WriteString "Options", "EditorFontName", *EditorFontName
		piniSettings->WriteInteger "Options", "EditorFontSize", EditorFontSize
		piniSettings->WriteString "Options", "InterfaceFontName", *InterfaceFontName
		piniSettings->WriteInteger "Options", "InterfaceFontSize", InterfaceFontSize
		piniSettings->WriteBool "Options", "DisplayMenuIcons", DisplayMenuIcons
		piniSettings->WriteBool "Options", "ShowMainToolbar", ShowMainToolbar
		pfrmMain->Menu->ImagesList = IIf(DisplayMenuIcons, pimgList, 0)
		ptbStandard->Visible = ShowMainToolbar
		pfrmMain->RequestAlign
		
		piniTheme->Load ExePath & "/Settings/Themes/" & *CurrentTheme & ".ini"
		piniTheme->WriteInteger("Colors", "BookmarksForeground", Bookmarks.ForegroundOption)
		piniTheme->WriteInteger("Colors", "BookmarksBackground", Bookmarks.BackgroundOption)
		piniTheme->WriteInteger("Colors", "BookmarksFrame", Bookmarks.FrameOption)
		piniTheme->WriteInteger("Colors", "BookmarksIndicator", Bookmarks.IndicatorOption)
		piniTheme->WriteInteger("FontStyles", "BookmarksBold", Bookmarks.Bold)
		piniTheme->WriteInteger("FontStyles", "BookmarksItalic", Bookmarks.Italic)
		piniTheme->WriteInteger("FontStyles", "BookmarksUnderline", Bookmarks.Underline)
		piniTheme->WriteInteger("Colors", "BreakpointsForeground", Breakpoints.ForegroundOption)
		piniTheme->WriteInteger("Colors", "BreakpointsBackground", Breakpoints.BackgroundOption)
		piniTheme->WriteInteger("Colors", "BreakpointsFrame", Breakpoints.FrameOption)
		piniTheme->WriteInteger("Colors", "BreakpointsIndicator", Breakpoints.IndicatorOption)
		piniTheme->WriteInteger("FontStyles", "BreakpointsBold", Breakpoints.Bold)
		piniTheme->WriteInteger("FontStyles", "BreakpointsItalic", Breakpoints.Italic)
		piniTheme->WriteInteger("FontStyles", "BreakpointsUnderline", Breakpoints.Underline)
		piniTheme->WriteInteger("Colors", "CommentsForeground", Comments.ForegroundOption)
		piniTheme->WriteInteger("Colors", "CommentsBackground", Comments.BackgroundOption)
		piniTheme->WriteInteger("Colors", "CommentsFrame", Comments.FrameOption)
		piniTheme->WriteInteger("FontStyles", "CommentsBold", Comments.Bold)
		piniTheme->WriteInteger("FontStyles", "CommentsItalic", Comments.Italic)
		piniTheme->WriteInteger("FontStyles", "CommentsUnderline", Comments.Underline)
		piniTheme->WriteInteger("Colors", "CurrentBracketsForeground", CurrentBrackets.ForegroundOption)
		piniTheme->WriteInteger("Colors", "CurrentBracketsBackground", CurrentBrackets.BackgroundOption)
		piniTheme->WriteInteger("Colors", "CurrentBracketsFrame", CurrentBrackets.FrameOption)
		piniTheme->WriteInteger("FontStyles", "CurrentBracketsBold", CurrentBrackets.Bold)
		piniTheme->WriteInteger("FontStyles", "CurrentBracketsItalic", CurrentBrackets.Italic)
		piniTheme->WriteInteger("FontStyles", "CurrentBracketsUnderline", CurrentBrackets.Underline)
		piniTheme->WriteInteger("Colors", "CurrentLineForeground", CurrentLine.ForegroundOption)
		piniTheme->WriteInteger("Colors", "CurrentLineBackground", CurrentLine.BackgroundOption)
		piniTheme->WriteInteger("Colors", "CurrentLineFrame", CurrentLine.FrameOption)
		piniTheme->WriteInteger("Colors", "CurrentWordForeground", CurrentWord.ForegroundOption)
		piniTheme->WriteInteger("Colors", "CurrentWordBackground", CurrentWord.BackgroundOption)
		piniTheme->WriteInteger("Colors", "CurrentWordFrame", CurrentWord.FrameOption)
		piniTheme->WriteInteger("FontStyles", "CurrentWordBold", CurrentWord.Bold)
		piniTheme->WriteInteger("FontStyles", "CurrentWordItalic", CurrentWord.Italic)
		piniTheme->WriteInteger("FontStyles", "CurrentWordUnderline", CurrentWord.Underline)
		piniTheme->WriteInteger("Colors", "ExecutionLineForeground", ExecutionLine.ForegroundOption)
		piniTheme->WriteInteger("Colors", "ExecutionLineBackground", ExecutionLine.BackgroundOption)
		piniTheme->WriteInteger("Colors", "ExecutionLineFrame", ExecutionLine.FrameOption)
		piniTheme->WriteInteger("Colors", "ExecutionLineIndicator", ExecutionLine.IndicatorOption)
		piniTheme->WriteInteger("Colors", "FoldLinesForeground", FoldLines.ForegroundOption)
		piniTheme->WriteInteger("Colors", "IndicatorLinesForeground", IndicatorLines.ForegroundOption)
		piniTheme->WriteInteger("Colors", "KeywordsForeground", Keywords.ForegroundOption)
		piniTheme->WriteInteger("Colors", "KeywordsBackground", Keywords.BackgroundOption)
		piniTheme->WriteInteger("Colors", "KeywordsFrame", Keywords.FrameOption)
		piniTheme->WriteInteger("FontStyles", "KeywordsBold", Keywords.Bold)
		piniTheme->WriteInteger("FontStyles", "KeywordsItalic", Keywords.Italic)
		piniTheme->WriteInteger("FontStyles", "KeywordsUnderline", Keywords.Underline)
		piniTheme->WriteInteger("Colors", "LineNumbersForeground", LineNumbers.ForegroundOption)
		piniTheme->WriteInteger("Colors", "LineNumbersBackground", LineNumbers.BackgroundOption)
		piniTheme->WriteInteger("FontStyles", "LineNumbersBold", LineNumbers.Bold)
		piniTheme->WriteInteger("FontStyles", "LineNumbersItalic", LineNumbers.Italic)
		piniTheme->WriteInteger("FontStyles", "LineNumbersUnderline", LineNumbers.Underline)
		piniTheme->WriteInteger("Colors", "NormalTextForeground", NormalText.ForegroundOption)
		piniTheme->WriteInteger("Colors", "NormalTextBackground", NormalText.BackgroundOption)
		piniTheme->WriteInteger("Colors", "NormalTextFrame", NormalText.FrameOption)
		piniTheme->WriteInteger("FontStyles", "NormalTextBold", NormalText.Bold)
		piniTheme->WriteInteger("FontStyles", "NormalTextItalic", NormalText.Italic)
		piniTheme->WriteInteger("FontStyles", "NormalTextUnderline", NormalText.Underline)
		piniTheme->WriteInteger("Colors", "PreprocessorsForeground", Preprocessors.ForegroundOption)
		piniTheme->WriteInteger("Colors", "PreprocessorsBackground", Preprocessors.BackgroundOption)
		piniTheme->WriteInteger("Colors", "PreprocessorsFrame", Preprocessors.FrameOption)
		piniTheme->WriteInteger("FontStyles", "PreprocessorsBold", Preprocessors.Bold)
		piniTheme->WriteInteger("FontStyles", "PreprocessorsItalic", Preprocessors.Italic)
		piniTheme->WriteInteger("FontStyles", "PreprocessorsUnderline", Preprocessors.Underline)
		piniTheme->WriteInteger("Colors", "SelectionForeground", Selection.ForegroundOption)
		piniTheme->WriteInteger("Colors", "SelectionBackground", Selection.BackgroundOption)
		piniTheme->WriteInteger("Colors", "SelectionFrame", Selection.FrameOption)
		piniTheme->WriteInteger("Colors", "SpaceIdentifiersForeground", SpaceIdentifiers.ForegroundOption)
		piniTheme->WriteInteger("Colors", "StringsForeground", Strings.ForegroundOption)
		piniTheme->WriteInteger("Colors", "StringsBackground", Strings.BackgroundOption)
		piniTheme->WriteInteger("Colors", "StringsFrame", Strings.FrameOption)
		piniTheme->WriteInteger("FontStyles", "StringsBold", Strings.Bold)
		piniTheme->WriteInteger("FontStyles", "StringsItalic", Strings.Italic)
		piniTheme->WriteInteger("FontStyles", "StringsUnderline", Strings.Underline)
		
		Dim As TabWindow Ptr tb
		For i As Integer = 0 To ptabCode->TabCount - 1
			tb = Cast(TabWindow Ptr, ptabCode->Tabs[i])
			tb->txtCode.Font.Name = *EditorFontName
			tb->txtCode.Font.Size = EditorFontSize
		Next
		newIndex = .cboLanguage.ItemIndex
	End With
	Exit Sub
	ErrorHandler:
	MsgBox ErrDescription(Err) & " (" & Err & ") " & _
	"in line " & Erl() & " " & _
	"in function " & ZGet(Erfn()) & " " & _
	"in module " & ZGet(Ermn())
End Sub

Private Sub frmOptions.Form_Close(ByRef Sender As Form, ByRef Action As Integer)
	If newIndex <> oldIndex Then MsgBox ML("Localization changes will be applied the next time the application is run.")
	If *InterfaceFontName <> *fOptions.oldInterfFontName OrElse InterfaceFontSize <> fOptions.oldInterfFontSize Then MsgBox ML("Interface font changes will be applied the next time the application is run.")
	If DisplayMenuIcons <> fOptions.oldDisplayMenuIcons Then MsgBox ML("Display icons in the menu changes will be applied the next time the application is run.")
	'If fOptions.HotKeysChanged Then MsgBox ML("Hotkey changes will be applied the next time the application is run.")
End Sub

Private Sub frmOptions.Form_Show(ByRef Sender As Form)
	With fOptions
		.LoadSettings
	End With
End Sub

Private Sub frmOptions.TreeView1_SelChange(ByRef Sender As TreeView, ByRef Item As TreeNode)
	With fOptions
		Dim Key As String = Item.Name
		.pnlGeneral.Visible = Key = "General"
		.pnlCodeEditor.Visible = Key = "CodeEditor"
		.pnlShortcuts.Visible = Key = "Shortcuts"
		.pnlThemes.Visible = Key = "Themes"
		.pnlColorsAndFonts.Visible = Key = "ColorsAndFonts"
		.pnlCompiler.Visible = Key = "Compiler"
		.pnlMake.Visible = Key = "MakeTool"
		.pnlDebugger.Visible = Key = "Debugger"
		.pnlTerminal.Visible = Key = "Terminal"
		.pnlDesigner.Visible = Key = "Designer"
		.pnlIncludes.Visible = Key = "Includes"
		.pnlLocalization.Visible = Key = "Localization"
		.pnlHelp.Visible = Key = "Help"
	End With
End Sub

Private Sub frmOptions.pnlIncludes_ActiveControlChange(ByRef Sender As Control)
	
End Sub

Private Sub frmOptions.cmdMFFPath_Click(ByRef Sender As Control)
	With fOptions
		If .BrowsD.Execute Then
			.txtMFFPath.Text = .BrowsD.Directory
		End If
	End With
End Sub

Private Sub frmOptions.cmdFont_Click(ByRef Sender As Control)
	With fOptions
		.FontD.Font.Name = *.EditFontName
		.FontD.Font.Size = .EditFontSize
		If .FontD.Execute Then
			WLet *.EditFontName, .FontD.Font.Name
			.EditFontSize = .FontD.Font.Size
			.lblFont.Font.Name = *.EditFontName
			.lblFont.Caption = *.EditFontName & ", " & .EditFontSize & "pt"
		End If
	End With
End Sub

Private Sub frmOptions.lstColorKeys_Change(ByRef Sender As Control)
	With fOptions
		Var i = fOptions.lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.lblColorForeground.BackColor = Max(0, .Colors(i, 0))
		.chkForeground.Checked = .Colors(i, 0) = -1
		
		.lblColorBackground.BackColor = Max(0, .Colors(i, 1))
		.lblColorBackground.Visible = .Colors(i, 1) <> -2
		.lblBackground.Visible = .Colors(i, 1) <> -2
		.cmdBackground.Visible = .Colors(i, 1) <> -2
		.chkBackground.Visible = .Colors(i, 1) <> -2
		.chkBackground.Checked = .Colors(i, 1) = -1
		
		.lblColorFrame.BackColor = Max(0, .Colors(i, 2))
		.lblColorFrame.Visible = .Colors(i, 2) <> -2
		.lblFrame.Visible = .Colors(i, 2) <> -2
		.cmdFrame.Visible = .Colors(i, 2) <> -2
		.chkFrame.Visible = .Colors(i, 2) <> -2
		.chkFrame.Checked = .Colors(i, 2) = -1
		
		.lblColorIndicator.BackColor = Max(0, .Colors(i, 3))
		.lblColorIndicator.Visible = .Colors(i, 3) <> -2
		.lblIndicator.Visible = .Colors(i, 3) <> -2
		.cmdIndicator.Visible = .Colors(i, 3) <> -2
		.chkIndicator.Visible = .Colors(i, 3) <> -2
		.chkIndicator.Checked = .Colors(i, 3) = -1
		
		.chkBold.Visible = .Colors(i, 4) <> -2
		.chkBold.Checked = .Colors(i, 4)
		.chkItalic.Visible = .Colors(i, 4) <> -2
		.chkItalic.Checked = .Colors(i, 5)
		.chkUnderline.Visible = .Colors(i, 4) <> -2
		.chkUnderline.Checked = .Colors(i, 6)
	End With
End Sub

Private Sub frmOptions.cmdForeground_Click(ByRef Sender As Control)
	With fOptions.ColorD
		Var i = fOptions.lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Color = fOptions.Colors(i, 0)
		If .Execute Then
			fOptions.lblColorForeground.BackColor = .Color
			fOptions.chkForeground.Checked = False
			fOptions.Colors(i, 0) = .Color
		End If
	End With
End Sub

Private Sub frmOptions.cmdBackground_Click(ByRef Sender As Control)
	With fOptions.ColorD
		Var i = fOptions.lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Color = fOptions.Colors(i, 1)
		If .Execute Then
			fOptions.lblColorBackground.BackColor = .Color
			fOptions.chkBackground.Checked = False
			fOptions.Colors(i, 1) = .Color
		End If
	End With
End Sub

Private Sub frmOptions.cmdFrame_Click(ByRef Sender As Control)
	With fOptions.ColorD
		Var i = fOptions.lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Color = fOptions.Colors(i, 2)
		If .Execute Then
			fOptions.lblColorFrame.BackColor = .Color
			fOptions.chkFrame.Checked = False
			fOptions.Colors(i, 2) = .Color
		End If
	End With
End Sub

Private Sub frmOptions.cmdIndicator_Click(ByRef Sender As Control)
	With fOptions.ColorD
		Var i = fOptions.lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Color = fOptions.Colors(i, 3)
		If .Execute Then
			fOptions.lblColorIndicator.BackColor = .Color
			fOptions.chkIndicator.Checked = False
			fOptions.Colors(i, 3) = .Color
		End If
	End With
End Sub

Private Sub frmOptions.cboTheme_Change(ByRef Sender As Control)
	With fOptions
		piniTheme->Load ExePath & "/Settings/Themes/" & fOptions.cboTheme.Text & ".ini"
		.Colors(0, 0) = piniTheme->ReadInteger("Colors", "BookmarksForeground", -1)
		.Colors(0, 1) = piniTheme->ReadInteger("Colors", "BookmarksBackground", -1)
		.Colors(0, 2) = piniTheme->ReadInteger("Colors", "BookmarksFrame", -1)
		.Colors(0, 3) = piniTheme->ReadInteger("Colors", "BookmarksIndicator", -1)
		.Colors(0, 4) = piniTheme->ReadInteger("FontStyles", "BookmarksBold", 0)
		.Colors(0, 5) = piniTheme->ReadInteger("FontStyles", "BookmarksItalic", 0)
		.Colors(0, 6) = piniTheme->ReadInteger("FontStyles", "BookmarksUnderline", 0)
		.Colors(1, 0) = piniTheme->ReadInteger("Colors", "BreakpointsForeground", -1)
		.Colors(1, 1) = piniTheme->ReadInteger("Colors", "BreakpointsBackground", -1)
		.Colors(1, 2) = piniTheme->ReadInteger("Colors", "BreakpointsFrame", -1)
		.Colors(1, 3) = piniTheme->ReadInteger("Colors", "BreakpointsIndicator", -1)
		.Colors(1, 4) = piniTheme->ReadInteger("FontStyles", "BreakpointsBold", 0)
		.Colors(1, 5) = piniTheme->ReadInteger("FontStyles", "BreakpointsItalic", 0)
		.Colors(1, 6) = piniTheme->ReadInteger("FontStyles", "BreakpointsUnderline", 0)
		.Colors(2, 0) = piniTheme->ReadInteger("Colors", "CommentsForeground", -1)
		.Colors(2, 1) = piniTheme->ReadInteger("Colors", "CommentsBackground", -1)
		.Colors(2, 2) = piniTheme->ReadInteger("Colors", "CommentsFrame", -1)
		.Colors(2, 4) = piniTheme->ReadInteger("FontStyles", "CommentsBold", 0)
		.Colors(2, 5) = piniTheme->ReadInteger("FontStyles", "CommentsItalic", 0)
		.Colors(2, 6) = piniTheme->ReadInteger("FontStyles", "CommentsUnderline", 0)
		.Colors(3, 0) = piniTheme->ReadInteger("Colors", "CurrentBracketsForeground", -1)
		.Colors(3, 1) = piniTheme->ReadInteger("Colors", "CurrentBracketsBackground", -1)
		.Colors(3, 2) = piniTheme->ReadInteger("Colors", "CurrentBracketsFrame", -1)
		.Colors(3, 3) = piniTheme->ReadInteger("Colors", "CurrentBracketsIndicator", -1)
		.Colors(3, 4) = piniTheme->ReadInteger("FontStyles", "CurrentBracketsBold", 0)
		.Colors(3, 5) = piniTheme->ReadInteger("FontStyles", "CurrentBracketsItalic", 0)
		.Colors(3, 6) = piniTheme->ReadInteger("FontStyles", "CurrentBracketsUnderline", 0)
		.Colors(4, 0) = piniTheme->ReadInteger("Colors", "CurrentLineForeground", -1)
		.Colors(4, 1) = piniTheme->ReadInteger("Colors", "CurrentLineBackground", -1)
		.Colors(4, 2) = piniTheme->ReadInteger("Colors", "CurrentLineFrame", -1)
		.Colors(5, 0) = piniTheme->ReadInteger("Colors", "CurrentWordForeground", -1)
		.Colors(5, 1) = piniTheme->ReadInteger("Colors", "CurrentWordBackground", -1)
		.Colors(5, 2) = piniTheme->ReadInteger("Colors", "CurrentWordFrame", -1)
		.Colors(5, 3) = piniTheme->ReadInteger("Colors", "CurrentWordIndicator", -1)
		.Colors(5, 4) = piniTheme->ReadInteger("FontStyles", "CurrentWordBold", 0)
		.Colors(5, 5) = piniTheme->ReadInteger("FontStyles", "CurrentWordItalic", 0)
		.Colors(5, 6) = piniTheme->ReadInteger("FontStyles", "CurrentWordUnderline", 0)
		.Colors(6, 0) = piniTheme->ReadInteger("Colors", "ExecutionLineForeground", -1)
		.Colors(6, 1) = piniTheme->ReadInteger("Colors", "ExecutionLineBackground", -1)
		.Colors(6, 2) = piniTheme->ReadInteger("Colors", "ExecutionLineFrame", -1)
		.Colors(6, 3) = piniTheme->ReadInteger("Colors", "ExecutionLineIndicator", -1)
		.Colors(7, 0) = piniTheme->ReadInteger("Colors", "FoldLinesForeground", -1)
		.Colors(8, 0) = piniTheme->ReadInteger("Colors", "IndicatorLinesForeground", -1)
		.Colors(9, 0) = piniTheme->ReadInteger("Colors", "KeywordsForeground", -1)
		.Colors(9, 1) = piniTheme->ReadInteger("Colors", "KeywordsBackground", -1)
		.Colors(9, 2) = piniTheme->ReadInteger("Colors", "KeywordsFrame", -1)
		.Colors(9, 4) = piniTheme->ReadInteger("FontStyles", "KeywordsBold", 0)
		.Colors(9, 5) = piniTheme->ReadInteger("FontStyles", "KeywordsItalic", 0)
		.Colors(9, 6) = piniTheme->ReadInteger("FontStyles", "KeywordsUnderline", 0)
		.Colors(10, 0) = piniTheme->ReadInteger("Colors", "LineNumbersForeground", -1)
		.Colors(10, 1) = piniTheme->ReadInteger("Colors", "LineNumbersBackground", -1)
		.Colors(10, 4) = piniTheme->ReadInteger("FontStyles", "LineNumbersBold", 0)
		.Colors(10, 5) = piniTheme->ReadInteger("FontStyles", "LineNumbersItalic", 0)
		.Colors(10, 6) = piniTheme->ReadInteger("FontStyles", "LineNumbersUnderline", 0)
		.Colors(11, 0) = piniTheme->ReadInteger("Colors", "NormalTextForeground", -1)
		.Colors(11, 1) = piniTheme->ReadInteger("Colors", "NormalTextBackground", -1)
		.Colors(11, 2) = piniTheme->ReadInteger("Colors", "NormalTextFrame", -1)
		.Colors(11, 4) = piniTheme->ReadInteger("FontStyles", "NormalTextBold", 0)
		.Colors(11, 5) = piniTheme->ReadInteger("FontStyles", "NormalTextItalic", 0)
		.Colors(11, 6) = piniTheme->ReadInteger("FontStyles", "NormalTextUnderline", 0)
		.Colors(12, 0) = piniTheme->ReadInteger("Colors", "PreprocessorsForeground", -1)
		.Colors(12, 1) = piniTheme->ReadInteger("Colors", "PreprocessorsBackground", -1)
		.Colors(12, 2) = piniTheme->ReadInteger("Colors", "PreprocessorsFrame", -1)
		.Colors(12, 4) = piniTheme->ReadInteger("FontStyles", "PreprocessorsBold", 0)
		.Colors(12, 5) = piniTheme->ReadInteger("FontStyles", "PreprocessorsItalic", 0)
		.Colors(12, 6) = piniTheme->ReadInteger("FontStyles", "PreprocessorsUnderline", 0)
		.Colors(13, 0) = piniTheme->ReadInteger("Colors", "SelectionForeground", -1)
		.Colors(13, 1) = piniTheme->ReadInteger("Colors", "SelectionBackground", -1)
		.Colors(13, 2) = piniTheme->ReadInteger("Colors", "SelectionFrame", -1)
		.Colors(14, 0) = piniTheme->ReadInteger("Colors", "SpaceIdentifiersForeground", -1)
		.Colors(15, 0) = piniTheme->ReadInteger("Colors", "StringsForeground", -1)
		.Colors(15, 1) = piniTheme->ReadInteger("Colors", "StringsBackground", -1)
		.Colors(15, 2) = piniTheme->ReadInteger("Colors", "StringsFrame", -1)
		.Colors(15, 4) = piniTheme->ReadInteger("FontStyles", "StringsBold", 0)
		.Colors(15, 5) = piniTheme->ReadInteger("FontStyles", "StringsItalic", 0)
		.Colors(15, 6) = piniTheme->ReadInteger("FontStyles", "StringsUnderline", 0)
		.lstColorKeys_Change(.lstColorKeys)
		Dim As TabWindow Ptr tb = Cast(TabWindow Ptr, ptabCode->SelectedTab)
		If tb <> 0 Then
			SetColors
			#ifdef __USE_GTK__
				tb->txtCode.Update
			#else
				RedrawWindow tb->txtCode.Handle, NULL, NULL, RDW_INVALIDATE
			#endif
		End If
	End With
End Sub

Private Sub frmOptions.chkForeground_Click(ByRef Sender As CheckBox)
	With fOptions
		Var i = .lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Colors(i, 0) = IIf(.chkForeground.Checked, -1, .lblColorForeground.BackColor)
	End With
End Sub

Private Sub frmOptions.chkBackground_Click(ByRef Sender As CheckBox)
	With fOptions
		Var i = .lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Colors(i, 1) = IIf(.chkBackground.Checked, -1, .lblColorBackground.BackColor)
	End With
End Sub

Private Sub frmOptions.chkFrame_Click(ByRef Sender As CheckBox)
	With fOptions
		Var i = .lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Colors(i, 2) = IIf(.chkFrame.Checked, -1, .lblColorFrame.BackColor)
	End With
End Sub

Private Sub frmOptions.chkIndicator_Click(ByRef Sender As CheckBox)
	With fOptions
		Var i = .lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Colors(i, 3) = IIf(.chkIndicator.Checked, -1, .lblColorIndicator.BackColor)
	End With
End Sub

Private Sub frmOptions.chkBold_Click(ByRef Sender As CheckBox)
	With fOptions
		Var i = .lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Colors(i, 4) = IIf(.chkBold.Checked, -1, 0)
	End With
End Sub

Private Sub frmOptions.chkItalic_Click(ByRef Sender As CheckBox)
	With fOptions
		Var i = .lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Colors(i, 5) = IIf(.chkItalic.Checked, -1, 0)
	End With
End Sub

Private Sub frmOptions.chkUnderline_Click(ByRef Sender As CheckBox)
	With fOptions
		Var i = .lstColorKeys.ItemIndex
		If i = -1 Then Exit Sub
		.Colors(i, 6) = IIf(.chkUnderline.Checked, -1, 0)
	End With
End Sub

Private Sub frmOptions.cmdAdd_Click(ByRef Sender As Control)
	If pfTheme->ShowModal() = ModalResults.OK Then
		With fOptions
			.cboTheme.AddItem pfTheme->txtThemeName.Text
			.cboTheme.ItemIndex = .cboTheme.IndexOf(pfTheme->txtThemeName.Text)
			.cboTheme_Change(Sender)
		End With
	End If
End Sub

Private Sub frmOptions.cmdRemove_Click(ByRef Sender As Control)
	With fOptions
		Kill ExePath & "/Settings/Themes/" & .cboTheme.Text & ".ini"
		.cboTheme.RemoveItem .cboTheme.ItemIndex
		.cboTheme.ItemIndex = 0
		.cboTheme_Change(Sender)
	End With
End Sub

Private Sub frmOptions.cmdAddCompiler_Click(ByRef Sender As Control)
	pfPath->txtVersion.Text = ""
	pfPath->txtPath.Text = ""
	If pfPath->ShowModal() = ModalResults.OK Then
		With fOptions
			If .cboCompiler32.IndexOf(pfPath->txtVersion.Text) = -1 Then
				.lvCompilerPaths.ListItems.Add pfPath->txtVersion.Text
				.lvCompilerPaths.ListItems.Item(.lvCompilerPaths.ListItems.Count - 1)->Text(1) = pfPath->txtPath.Text
				.cboCompiler32.AddItem pfPath->txtVersion.Text
				.cboCompiler64.AddItem pfPath->txtVersion.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End With
	End If
End Sub

Private Sub frmOptions.cmdChangeCompiler_Click(ByRef Sender As Control)
	With fOptions
		If .lvCompilerPaths.SelectedItem = 0 Then Exit Sub
		pfPath->txtVersion.Text = .lvCompilerPaths.SelectedItem->Text(0)
		pfPath->txtPath.Text = .lvCompilerPaths.SelectedItem->Text(1)
		If pfPath->ShowModal() = ModalResults.OK Then
			If .lvCompilerPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text OrElse .cboCompiler32.IndexOf(pfPath->txtVersion.Text) = -1 Then
				Var i = .cboCompiler32.IndexOf(.lvCompilerPaths.SelectedItem->Text(0))
				.cboCompiler32.Item(i) = pfPath->txtVersion.Text
				.cboCompiler64.Item(i) = pfPath->txtVersion.Text
				.lvCompilerPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text
				.lvCompilerPaths.SelectedItem->Text(1) = pfPath->txtPath.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End If
	End With
End Sub

Private Sub frmOptions.cmdRemoveCompiler_Click(ByRef Sender As Control)
	With fOptions
		If .lvCompilerPaths.SelectedItem = 0 Then Exit Sub
		Var iIndex = .cboCompiler32.IndexOf(.lvCompilerPaths.SelectedItem->Text(0))
		If iIndex > -1 Then .cboCompiler32.RemoveItem iIndex
		If .cboCompiler32.ItemIndex = -1 Then .cboCompiler32.ItemIndex = 0
		iIndex = .cboCompiler64.IndexOf(.lvCompilerPaths.SelectedItem->Text(0))
		If iIndex > -1 Then .cboCompiler64.RemoveItem iIndex
		If .cboCompiler64.ItemIndex = -1 Then .cboCompiler64.ItemIndex = 0
		.lvCompilerPaths.ListItems.Remove .lvCompilerPaths.SelectedItemIndex
	End With
End Sub

Private Sub frmOptions.cmdClearCompilers_Click(ByRef Sender As Control)
	With fOptions
		.lvCompilerPaths.ListItems.Clear
		.cboCompiler32.Clear
		.cboCompiler64.Clear
		.cboCompiler32.AddItem ML("(not selected)")
		.cboCompiler64.AddItem ML("(not selected)")
		.cboCompiler32.ItemIndex = 0
		.cboCompiler64.ItemIndex = 0
	End With
End Sub

Private Sub frmOptions.cmdAddMakeTool_Click(ByRef Sender As Control)
	pfPath->txtVersion.Text = ""
	pfPath->txtPath.Text = ""
	If pfPath->ShowModal() = ModalResults.OK Then
		With fOptions
			If .cboMakeTool.IndexOf(pfPath->txtVersion.Text) = -1 Then
				.lvMakeToolPaths.ListItems.Add pfPath->txtVersion.Text
				.lvMakeToolPaths.ListItems.Item(.lvMakeToolPaths.ListItems.Count - 1)->Text(1) = pfPath->txtPath.Text
				.cboMakeTool.AddItem pfPath->txtVersion.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End With
	End If
End Sub

Private Sub frmOptions.cmdChangeMakeTool_Click(ByRef Sender As Control)
	With fOptions
		If .lvMakeToolPaths.SelectedItem = 0 Then Exit Sub
		pfPath->txtVersion.Text = .lvMakeToolPaths.SelectedItem->Text(0)
		pfPath->txtPath.Text = .lvMakeToolPaths.SelectedItem->Text(1)
		If pfPath->ShowModal() = ModalResults.OK Then
			If .lvMakeToolPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text OrElse .cboMakeTool.IndexOf(pfPath->txtVersion.Text) = -1 Then
				Var i = .cboTerminal.IndexOf(.lvMakeToolPaths.SelectedItem->Text(0))
				.cboMakeTool.Item(i) = pfPath->txtVersion.Text
				.lvMakeToolPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text
				.lvMakeToolPaths.SelectedItem->Text(1) = pfPath->txtPath.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End If
	End With
End Sub

Private Sub frmOptions.cmdRemoveMakeTool_Click(ByRef Sender As Control)
	With fOptions
		If .lvMakeToolPaths.SelectedItem = 0 Then Exit Sub
		Var iIndex = .cboMakeTool.IndexOf(.lvMakeToolPaths.SelectedItem->Text(0))
		If iIndex > -1 Then .cboMakeTool.RemoveItem iIndex
		If .cboMakeTool.ItemIndex = -1 Then .cboMakeTool.ItemIndex = 0
		.lvMakeToolPaths.ListItems.Remove .lvMakeToolPaths.SelectedItemIndex
	End With
End Sub

Private Sub frmOptions.cmdClearMakeTools_Click(ByRef Sender As Control)
	With fOptions
		.lvMakeToolPaths.ListItems.Clear
		.cboMakeTool.Clear
		.cboMakeTool.AddItem ML("(not selected)")
		.cboMakeTool.ItemIndex = 0
	End With
End Sub

Private Sub frmOptions.cmdAddDebugger_Click(ByRef Sender As Control)
	pfPath->txtVersion.Text = ""
	pfPath->txtPath.Text = ""
	If pfPath->ShowModal() = ModalResults.OK Then
		With fOptions
			If .cboDebugger.IndexOf(pfPath->txtVersion.Text) = -1 Then
				.lvDebuggerPaths.ListItems.Add pfPath->txtVersion.Text
				.lvDebuggerPaths.ListItems.Item(.lvDebuggerPaths.ListItems.Count - 1)->Text(1) = pfPath->txtPath.Text
				.cboDebugger.AddItem pfPath->txtVersion.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End With
	End If
End Sub

Private Sub frmOptions.cmdChangeDebugger_Click(ByRef Sender As Control)
	With fOptions
		If .lvDebuggerPaths.SelectedItem = 0 Then Exit Sub
		pfPath->txtVersion.Text = .lvDebuggerPaths.SelectedItem->Text(0)
		pfPath->txtPath.Text = .lvDebuggerPaths.SelectedItem->Text(1)
		If pfPath->ShowModal() = ModalResults.OK Then
			If .lvDebuggerPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text OrElse .cboDebugger.IndexOf(pfPath->txtVersion.Text) = -1 Then
				Var i = .cboDebugger.IndexOf(.lvDebuggerPaths.SelectedItem->Text(0))
				.cboDebugger.Item(i) = pfPath->txtVersion.Text
				.lvDebuggerPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text
				.lvDebuggerPaths.SelectedItem->Text(1) = pfPath->txtPath.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End If
	End With
End Sub

Private Sub frmOptions.cmdRemoveDebugger_Click(ByRef Sender As Control)
	With fOptions
		If .lvDebuggerPaths.SelectedItem = 0 Then Exit Sub
		Var iIndex = .cboDebugger.IndexOf(.lvDebuggerPaths.SelectedItem->Text(0))
		If iIndex > -1 Then .cboDebugger.RemoveItem iIndex
		If .cboDebugger.ItemIndex = -1 Then .cboDebugger.ItemIndex = 0
		.lvDebuggerPaths.ListItems.Remove .lvDebuggerPaths.SelectedItemIndex
	End With
End Sub

Private Sub frmOptions.cmdClearDebuggers_Click(ByRef Sender As Control)
	With fOptions
		.lvDebuggerPaths.ListItems.Clear
		.cboDebugger.Clear
		.cboDebugger.AddItem ML("Integrated IDE Debugger")
		.cboDebugger.ItemIndex = 0
	End With
End Sub

Private Sub frmOptions.cmdAddTerminal_Click(ByRef Sender As Control)
	pfPath->txtVersion.Text = ""
	pfPath->txtPath.Text = ""
	If pfPath->ShowModal() = ModalResults.OK Then
		With fOptions
			If .cboTerminal.IndexOf(pfPath->txtVersion.Text) = -1 Then
				.lvTerminalPaths.ListItems.Add pfPath->txtVersion.Text
				.lvTerminalPaths.ListItems.Item(.lvTerminalPaths.ListItems.Count - 1)->Text(1) = pfPath->txtPath.Text
				.cboTerminal.AddItem pfPath->txtVersion.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End With
	End If
End Sub

Private Sub frmOptions.cmdChangeTerminal_Click(ByRef Sender As Control)
	With fOptions
		If .lvTerminalPaths.SelectedItem = 0 Then Exit Sub
		pfPath->txtVersion.Text = .lvTerminalPaths.SelectedItem->Text(0)
		pfPath->txtPath.Text = .lvTerminalPaths.SelectedItem->Text(1)
		If pfPath->ShowModal() = ModalResults.OK Then
			If .lvTerminalPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text OrElse .cboTerminal.IndexOf(pfPath->txtVersion.Text) = -1 Then
				Var i = .cboTerminal.IndexOf(.lvTerminalPaths.SelectedItem->Text(0))
				.cboTerminal.Item(i) = pfPath->txtVersion.Text
				.lvTerminalPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text
				.lvTerminalPaths.SelectedItem->Text(1) = pfPath->txtPath.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End If
	End With
End Sub

Private Sub frmOptions.cmdRemoveTerminal_Click(ByRef Sender As Control)
	With fOptions
		If .lvTerminalPaths.SelectedItem = 0 Then Exit Sub
		Var iIndex = .cboTerminal.IndexOf(.lvTerminalPaths.SelectedItem->Text(0))
		If iIndex > -1 Then .cboTerminal.RemoveItem iIndex
		If .cboTerminal.ItemIndex = -1 Then .cboTerminal.ItemIndex = 0
		.lvTerminalPaths.ListItems.Remove .lvTerminalPaths.SelectedItemIndex
	End With
End Sub

Private Sub frmOptions.cmdClearTerminals_Click(ByRef Sender As Control)
	With fOptions
		.lvTerminalPaths.ListItems.Clear
		.cboTerminal.Clear
		.cboTerminal.AddItem ML("(not selected)")
		.cboTerminal.ItemIndex = 0
	End With
End Sub

Private Sub frmOptions.cmdAddHelp_Click(ByRef Sender As Control)
	pfPath->txtVersion.Text = ""
	pfPath->txtPath.Text = ""
	If pfPath->ShowModal() = ModalResults.OK Then
		With fOptions
			If .cboHelp.IndexOf(pfPath->txtVersion.Text) = -1 Then
				.lvHelpPaths.ListItems.Add pfPath->txtVersion.Text
				.lvHelpPaths.ListItems.Item(.lvHelpPaths.ListItems.Count - 1)->Text(1) = pfPath->txtPath.Text
				.cboHelp.AddItem pfPath->txtVersion.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End With
	End If
End Sub

Private Sub frmOptions.cmdChangeHelp_Click(ByRef Sender As Control)
	With fOptions
		If .lvHelpPaths.SelectedItem = 0 Then Exit Sub
		pfPath->txtVersion.Text = .lvHelpPaths.SelectedItem->Text(0)
		pfPath->txtPath.Text = .lvHelpPaths.SelectedItem->Text(1)
		If pfPath->ShowModal() = ModalResults.OK Then
			If .lvHelpPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text OrElse .cboHelp.IndexOf(pfPath->txtVersion.Text) = -1 Then
				Var i = .cboHelp.IndexOf(.lvHelpPaths.SelectedItem->Text(0))
				.cboHelp.Item(i) = pfPath->txtVersion.Text
				.lvHelpPaths.SelectedItem->Text(0) = pfPath->txtVersion.Text
				.lvHelpPaths.SelectedItem->Text(1) = pfPath->txtPath.Text
			Else
				MsgBox ML("This version is exists!")
			End If
		End If
	End With
End Sub

Private Sub frmOptions.cmdRemoveHelp_Click(ByRef Sender As Control)
	With fOptions
		If .lvHelpPaths.SelectedItem = 0 Then Exit Sub
		Var iIndex = .cboHelp.IndexOf(.lvHelpPaths.SelectedItem->Text(0))
		If iIndex > -1 Then .cboHelp.RemoveItem iIndex
		If .cboHelp.ItemIndex = -1 Then .cboHelp.ItemIndex = 0
		.lvHelpPaths.ListItems.Remove .lvHelpPaths.SelectedItemIndex
	End With
End Sub

Private Sub frmOptions.cmdClearHelps_Click(ByRef Sender As Control)
	With fOptions
		.lvHelpPaths.ListItems.Clear
		.cboHelp.Clear
		.cboHelp.AddItem ML("(not selected)")
		.cboHelp.ItemIndex = 0
	End With
End Sub

Private Sub frmOptions.cmdInterfaceFont_Click(ByRef Sender As Control)
	With fOptions
		.FontD.Font.Name = *.InterfFontName
		.FontD.Font.Size = .InterfFontSize
		If .FontD.Execute Then
			WLet *.InterfFontName, .FontD.Font.Name
			.InterfFontSize = .FontD.Font.Size
			.lblInterfaceFont.Font.Name = *.InterfFontName
			.lblInterfaceFont.Caption = *.InterfFontName & ", " & .InterfFontSize & "pt"
		End If
	End With
End Sub

Private Sub frmOptions.cmdAddInclude_Click(ByRef Sender As Control)
	pfPath->txtPath.Text = ""
	pfPath->ChooseFolder = True
	If pfPath->ShowModal() = ModalResults.OK Then
		With fOptions
			If Not .lstIncludePaths.Items.Contains(pfPath->txtPath.Text) Then
				.lstIncludePaths.Items.Add pfPath->txtPath.Text
				.lstIncludePaths.AddItem pfPath->txtPath.Text
			Else
				MsgBox ML("This path is exists!")
			End If
		End With
	End If
End Sub

Private Sub frmOptions.cmdAddLibrary_Click(ByRef Sender As Control)
	pfPath->txtPath.Text = ""
	pfPath->ChooseFolder = True
	If pfPath->ShowModal() = ModalResults.OK Then
		With fOptions
			If Not .lstLibraryPaths.Items.Contains(pfPath->txtPath.Text) Then
				.lstLibraryPaths.Items.Add pfPath->txtPath.Text
				.lstLibraryPaths.AddItem pfPath->txtPath.Text
			Else
				MsgBox ML("This path is exists!")
			End If
		End With
	End If
End Sub

Private Sub frmOptions.cmdRemoveInclude_Click(ByRef Sender As Control)
	Var Index = fOptions.lstIncludePaths.ItemIndex
	If Index <> -1 Then fOptions.lstIncludePaths.RemoveItem Index
End Sub

Private Sub frmOptions.cmdRemoveLibrary_Click(ByRef Sender As Control)
	Var Index = fOptions.lstLibraryPaths.ItemIndex
	If Index <> -1 Then fOptions.lstLibraryPaths.RemoveItem Index
End Sub

Private Sub frmOptions.cmdProjectsPath_Click(ByRef Sender As Control)
	With fOptions
		If .BrowsD.Execute Then
			.txtProjectsPath.Text = .BrowsD.Directory
		End If
	End With
End Sub

Private Sub frmOptions.lvShortcuts_SelectedItemChanged(ByRef Sender As ListView, ByVal ItemIndex As Integer)
	With fOptions
		Var Index = .lvShortcuts.SelectedItemIndex
		If Index > -1 Then
			.hkShortcut.Text = .lvShortcuts.SelectedItem->Text(1)
		End If
	End With
End Sub

Private Sub frmOptions.cmdSetShortcut_Click(ByRef Sender As Control)
	With fOptions
		Var Index = .lvShortcuts.SelectedItemIndex
		If Index > -1 Then
			.lvShortcuts.SelectedItem->Text(1) = .hkShortcut.Text
			.HotKeysChanged = True
		End If
	End With
End Sub
