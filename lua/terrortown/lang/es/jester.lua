L = LANG.GetLanguageTableReference("es")

-- GENERAL ROLE LANGUAGE STRINGS
L[JESTER.name] = "Jester"
L[JESTER.defaultTeam] = "Team Jesters"
L["hilite_win_" .. JESTER.defaultTeam] = "EL JESTER GANA"
L["win_" .. JESTER.defaultTeam] = "¡El Jester ha ganado!"
L["info_popup_" .. JESTER.name] = [[¡Eres el Jester! ¡Genera problemas  y has que te maten!]]
L["body_found_" .. JESTER.abbr] = "¡Era un Jester!"
L["search_role_" .. JESTER.abbr] = "Esta persona era un Jester."
L["ev_win_" .. JESTER.defaultTeam] = "¡El torpe bufón ha ganado la ronda!"
L["target_" .. JESTER.name] = "Jester"
L["ttt2_desc_" .. JESTER.name] = [[El Jester es visible a los demás traidores, pero no para los inocentes o roles "normales" (Exceptuando roles específicos de traidor y el Clarividente).
El Jester no inflige ningún daño ni puede suicidarse. Si de alguna manera muere, ganará. ¡No le apuntes a la cabeza!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_killed_by_player"] = "¡{nick} asesinó al Jester!"
L["ttt2_role_jester_killer_info"] = "¡Fuiste asesinado porque mataste al Jester!"
L["ttt2_role_jester_info_no_kill"] = "¡No mates al Jester!"
L["ttt2_role_jester_info_no_jester"] = "¡No apareció un Jester esta ronda!"
L["ttt2_role_jester_info_jester_single"] = "¡'{playername}' es el Jester!"
L["ttt2_role_jester_info_jester_multiple"] = "¡'{playernames}' son los Jesters!"

-- WINSTATE LANGS
L["ttt2_role_jester_winstate_0"] = "Condición de victoria al azar activa."
L["ttt2_role_jester_winstate_1"] = "Condición de Victoria (Jester) 1: Ganarás si mueres."
L["ttt2_role_jester_winstate_2"] = "Condición de Victoria (Jester) 2: Reaparecerás con el rol contrario de tu asesino."
L["ttt2_role_jester_winstate_3"] = "Condición de Victoria (Jester) 3: Reaparecerás con el rol contrario al de tu asesino cuando este muera."
L["ttt2_role_jester_winstate_4"] = "Condición de Victoria (Jester) 4: Reaparecerás con el rol de tu asesino cuando este muera."
L["ttt2_role_jester_winstate_5"] = "Condición de Victoria (Jester) 5: Reaparecerás con el rol de tu asesino y este morirá."
L["ttt2_role_jester_winstate_6"] = "Condición de Victoria (Jester) 6: Reaparecerás con el rol contrario al de tu asesino y este morirá."
L["ttt2_role_jester_winstate_7"] = "Condición de Victoria (Jester) 7: Reaparecerás con el rol de tu asesino y este morirá, al menos que este sea un AsesinoSerial o un traidor."
