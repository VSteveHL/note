#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


CapsLock::CTRL
RSHIFT & CapsLock::CapsLock
\::BS
BS::\
+BS::|
`::ESC
+`::~
RSHIFT & RALT::SendRaw, ``
Return


RSHIFT & [::Send, {UP}
Return   
RSHIFT & /::Send, {DOWN}
Return   
RSHIFT & `;::Send, {LEFT}
Return   
RSHIFT & '::Send, {RIGHT}
Return

RSHIFT & w::MouseMove, 0, -40, 0, R
Return   
RSHIFT & s::MouseMove, 0, 40, 0, R
Return   
RSHIFT & a::MouseMove, -40, 0, 0, R
Return   
RSHIFT & d::MouseMove, 40, 0, 0, R
Return
RSHIFT & ,::Send, {Click}
Return
RSHIFT & .::Send, {Click, right}
Return
