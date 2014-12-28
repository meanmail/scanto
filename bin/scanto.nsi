Name "Scan To"

OutFile "setup-scanto-0.4-x86-windows.exe"

InstallDir $PROGRAMFILES\AUtils\ScanTo
InstallDirRegKey HKLM "SOFTWARE\ScanTo" "Install_Dir"

XPStyle on

; Request application privileges
RequestExecutionLevel admin

; ---------------------------------------------------------------------
; Pages

Page license
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;-----------------------------------------------------------------------
; First is default
LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Czech.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Dutch.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\French.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\German.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Korean.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Russian.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Spanish.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Swedish.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\TradChinese.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Slovak.nlf"

; License data
LicenseLangString myLicenseData ${LANG_ENGLISH} "license.txt"
LicenseLangString myLicenseData ${LANG_CZECH} "license.txt"
LicenseLangString myLicenseData ${LANG_DUTCH} "license.txt"
LicenseLangString myLicenseData ${LANG_FRENCH} "license.txt"
LicenseLangString myLicenseData ${LANG_GERMAN} "license.txt"
LicenseLangString myLicenseData ${LANG_KOREAN} "license.txt"
LicenseLangString myLicenseData ${LANG_RUSSIAN} "license.txt"
LicenseLangString myLicenseData ${LANG_SPANISH} "license.txt"
LicenseLangString myLicenseData ${LANG_SWEDISH} "license.txt"
LicenseLangString myLicenseData ${LANG_TRADCHINESE} "license.txt"
LicenseLangString myLicenseData ${LANG_SIMPCHINESE} "license.txt"
LicenseLangString myLicenseData ${LANG_SLOVAK} "license.txt"

LicenseData $(myLicenseData)

; Menu command caption
LangString cmdCaption ${LANG_ENGLISH} "Scan to..."
LangString cmdCaption ${LANG_CZECH} "Scan to..."
LangString cmdCaption ${LANG_DUTCH} "Scan to..."
LangString cmdCaption ${LANG_FRENCH} "Scan to..."
LangString cmdCaption ${LANG_GERMAN} "Scan to..."
LangString cmdCaption ${LANG_KOREAN} "Scan to..."
LangString cmdCaption ${LANG_RUSSIAN} "Сканировать в ..."
LangString cmdCaption ${LANG_SPANISH} "Scan to..."
LangString cmdCaption ${LANG_SWEDISH} "Scan to..."
LangString cmdCaption ${LANG_TRADCHINESE} "Scan to..."
LangString cmdCaption ${LANG_SIMPCHINESE} "Scan to..."
LangString cmdCaption ${LANG_SLOVAK} "Scan to..."
;-----------------------------------------------------------------------------------------------------

Section ""
  SetOutPath $INSTDIR
   File "scanto.exe"
   File "license.txt"
   SetOutPath $INSTDIR\lang
      File "lang\scanto.*.po"

  ; Write the installation path into the registry
  WriteRegStr HKLM "SOFTWARE\ScanTo" "Install_Dir" "$INSTDIR"
  WriteRegStr HKCR "Directory\shell\scanto" "" $(cmdCaption)
  WriteRegStr HKCR "Directory\shell\scanto\command" "" "$INSTDIR\scanto.exe $\"%1$\""

  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ScanTo" "DisplayName" "ScanTo"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ScanTo" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ScanTo" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ScanTo" "NoRepair" 1
  WriteUninstaller "uninstall.exe"

SectionEnd

;------------------------------------------------------------------------
; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKCR "Directory\shell\scanto"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ScanTo"
  DeleteRegKey HKLM SOFTWARE\ScanTo

  ; Remove files and uninstaller
  Delete $INSTDIR\scanto.exe
  Delete $INSTDIR\license.txt
  Delete $INSTDIR\config.xml
  Delete $INSTDIR\uninstall.exe
  Delete $INSTDIR\lang\*

  ; Remove directories used
  RMDir "$INSTDIR\lang"
  RMDir "$INSTDIR"
  RMDir "$PROGRAMFILES\AUtils"

SectionEnd