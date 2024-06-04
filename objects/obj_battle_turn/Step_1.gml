if (proceed == true)
    timer++;
if (turn != Battle_GetTurnNumber())
{
    Battle_EndTurn();
    Battle_SetTurnNumber(Battle_GetTurnNumber() - 1);
}


