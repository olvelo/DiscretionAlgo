//+------------------------------------------------------------------+
//|                                                      sweep.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
//| Global variables                                                 |
//+------------------------------------------------------------------+

   // Inputs
   input int number_of_bars = 300;
   
   // Arrays for storing open, high, close and time for various timeframes
   double highs_m1[];
   double closes_m1[];
   double opens_m1[];
   double lows_m1[];
   datetime times_m1[];
      
   double highs_m15[];
   double closes_m15[];
   double opens_m15[];
   double lows_m15[];
   datetime times_m15[];
   
   double highs_m30[];
   double closes_m30[];
   double opens_m30[];
   double lows_m30[];
   datetime times_m30[];
   
   double highs_h1[];
   double closes_h1[];
   double opens_h1[];
   double lows_h1[];
   datetime times_h1[];
   
   double highs_h4[];
   double closes_h4[];
   double opens_h4[];
   double lows_h4[];
   datetime times_h4[];
   
   double highs_d1[];
   double closes_d1[];
   double opens_d1[];
   double lows_d1[];
   datetime times_d1[];
   
   // Datetime for checking if we have a new candle
   datetime CandleTime_m1;
   datetime CandleTime_m15;
   datetime CandleTime_m30;
   datetime CandleTime_h1;
   datetime CandleTime_h4;
   datetime CandleTime_d1;
   
   // Boolean variable for sending notifications or not
   input bool NotifyOnSweep = True;
   input bool NotifyOnCM = True;
   
   // Boolean inputs for which sweep + cm combinations to look for
   input bool sweep_h4_cm_m15 = True;
   input bool sweep_h1_cm_m15 = True;

//+------------------------------------------------------------------+
//| Setup of arrays to use                                           |
//+------------------------------------------------------------------+
void SetupArrays(){ 

   // Resize arrays to use the number of bars in input variable
   ArrayResize(highs_m1, number_of_bars);
   ArrayResize(closes_m1, number_of_bars);
   ArrayResize(opens_m1, number_of_bars);
   ArrayResize(lows_m1, number_of_bars);
   ArrayResize(times_m1, number_of_bars);
   
   ArrayResize(highs_m15, number_of_bars);
   ArrayResize(closes_m15, number_of_bars);
   ArrayResize(opens_m15, number_of_bars);
   ArrayResize(lows_m15, number_of_bars);
   ArrayResize(times_m15, number_of_bars);
   
   ArrayResize(highs_m30, number_of_bars);
   ArrayResize(closes_m30, number_of_bars);
   ArrayResize(opens_m30, number_of_bars);
   ArrayResize(lows_m30, number_of_bars);
   ArrayResize(times_m30, number_of_bars);
   
   ArrayResize(highs_h1, number_of_bars);
   ArrayResize(closes_h1, number_of_bars);
   ArrayResize(opens_h1, number_of_bars);
   ArrayResize(lows_h1, number_of_bars);
   ArrayResize(times_h1, number_of_bars);
   
   ArrayResize(highs_h4, number_of_bars);
   ArrayResize(closes_h4, number_of_bars);
   ArrayResize(opens_h4, number_of_bars);
   ArrayResize(lows_h4, number_of_bars);
   ArrayResize(times_h4, number_of_bars);
   
   ArrayResize(highs_d1, number_of_bars);
   ArrayResize(closes_d1, number_of_bars);
   ArrayResize(opens_d1, number_of_bars);
   ArrayResize(lows_d1, number_of_bars);
   ArrayResize(times_d1, number_of_bars);
   
   // Fill arrays
   for(int i=0; i < number_of_bars; i++){
      highs_m1[i] = iHigh(Symbol(), PERIOD_M1, number_of_bars - i);
      closes_m1[i] = iClose(Symbol(), PERIOD_M1, number_of_bars - i);
      opens_m1[i] = iOpen(Symbol(), PERIOD_M1, number_of_bars - i);
      lows_m1[i] = iLow(Symbol(), PERIOD_M1, number_of_bars - i);
      times_m1[i] = iTime(Symbol(), PERIOD_M1, number_of_bars - i);
   
      highs_m15[i] = iHigh(Symbol(), PERIOD_M15, number_of_bars - i);
      closes_m15[i] = iClose(Symbol(), PERIOD_M15, number_of_bars - i);
      opens_m15[i] = iOpen(Symbol(), PERIOD_M15, number_of_bars - i);
      lows_m15[i] = iLow(Symbol(), PERIOD_M15, number_of_bars - i);
      times_m15[i] = iTime(Symbol(), PERIOD_M15, number_of_bars - i);
   
      highs_m30[i] = iHigh(Symbol(), PERIOD_M30, number_of_bars - i);
      closes_m30[i] = iClose(Symbol(), PERIOD_M30, number_of_bars - i);
      opens_m30[i] = iOpen(Symbol(), PERIOD_M30, number_of_bars - i);
      lows_m30[i] = iLow(Symbol(), PERIOD_M30, number_of_bars - i);
      times_m30[i] = iTime(Symbol(), PERIOD_M30, number_of_bars - i);
   
      highs_h1[i] = iHigh(Symbol(), PERIOD_H1, number_of_bars - i);
      closes_h1[i] = iClose(Symbol(), PERIOD_H1, number_of_bars - i);
      opens_h1[i] = iOpen(Symbol(), PERIOD_H1, number_of_bars - i);
      lows_h1[i] = iLow(Symbol(), PERIOD_H1, number_of_bars - i);
      times_h1[i] = iTime(Symbol(), PERIOD_H1, number_of_bars - i);
   
      highs_h4[i] = iHigh(Symbol(), PERIOD_H4, number_of_bars - i);
      closes_h4[i] = iClose(Symbol(), PERIOD_H4, number_of_bars - i);
      opens_h4[i] = iOpen(Symbol(), PERIOD_H4, number_of_bars - i);
      lows_h4[i] = iLow(Symbol(), PERIOD_H4, number_of_bars - i);
      times_h4[i] = iTime(Symbol(), PERIOD_H4, number_of_bars - i);
      
      highs_d1[i] = iHigh(Symbol(), PERIOD_D1, number_of_bars - i);
      closes_d1[i] = iClose(Symbol(), PERIOD_D1, number_of_bars - i);
      opens_d1[i] = iOpen(Symbol(), PERIOD_D1, number_of_bars - i);
      lows_d1[i] = iLow(Symbol(), PERIOD_D1, number_of_bars - i);
      times_d1[i] = iTime(Symbol(), PERIOD_D1, number_of_bars - i);
   }
}
  
//+------------------------------------------------------------------+
//| Conditional update of arrays                                     |
//+------------------------------------------------------------------+
void UpdateArrays(bool update_m1, bool update_m15, bool update_m30, bool update_h1, bool update_h4, bool update_d1){

   if(update_m1){
      for(int i=0; i < number_of_bars; i++){
         highs_m1[i] = iHigh(Symbol(), PERIOD_M1, number_of_bars - i);
         closes_m1[i] = iClose(Symbol(), PERIOD_M1, number_of_bars - i);
         opens_m1[i] = iOpen(Symbol(), PERIOD_M1, number_of_bars - i);
         lows_m1[i] = iLow(Symbol(), PERIOD_M1, number_of_bars - i);
         times_m1[i] = iTime(Symbol(), PERIOD_M1, number_of_bars - i);
      }
   }

   if(update_m15){
      for(int i=0; i < number_of_bars; i++){
         highs_m15[i] = iHigh(Symbol(), PERIOD_M15, number_of_bars - i);
         closes_m15[i] = iClose(Symbol(), PERIOD_M15, number_of_bars - i);
         opens_m15[i] = iOpen(Symbol(), PERIOD_M15, number_of_bars - i);
         lows_m15[i] = iLow(Symbol(), PERIOD_M15, number_of_bars - i);
         times_m15[i] = iTime(Symbol(), PERIOD_M15, number_of_bars - i);
      }
   }
   
   if(update_m30){
      for(int i=0; i < number_of_bars; i++){
         highs_m30[i] = iHigh(Symbol(), PERIOD_M30, number_of_bars - i);
         closes_m30[i] = iClose(Symbol(), PERIOD_M30, number_of_bars - i);
         opens_m30[i] = iOpen(Symbol(), PERIOD_M30, number_of_bars - i);
         lows_m30[i] = iLow(Symbol(), PERIOD_M30, number_of_bars - i);
         times_m30[i] = iTime(Symbol(), PERIOD_M30, number_of_bars - i);
      }
   }
   
   if(update_h1){
      for(int i=0; i < number_of_bars; i++){
         highs_h1[i] = iHigh(Symbol(), PERIOD_H1, number_of_bars - i);
         closes_h1[i] = iClose(Symbol(), PERIOD_H1, number_of_bars - i);
         opens_h1[i] = iOpen(Symbol(), PERIOD_H1, number_of_bars - i);
         lows_h1[i] = iLow(Symbol(), PERIOD_H1, number_of_bars - i);
         times_h1[i] = iTime(Symbol(), PERIOD_H1, number_of_bars - i);
      }
   }
   
   if(update_h4){
      for(int i=0; i < number_of_bars; i++){
         highs_h4[i] = iHigh(Symbol(), PERIOD_H4, number_of_bars - i);
         closes_h4[i] = iClose(Symbol(), PERIOD_H4, number_of_bars - i);
         opens_h4[i] = iOpen(Symbol(), PERIOD_H4, number_of_bars - i);
         lows_h4[i] = iLow(Symbol(), PERIOD_H4, number_of_bars - i);
         times_h4[i] = iTime(Symbol(), PERIOD_H4, number_of_bars - i);
      }
   }
   
   if (update_d1){
      for (int i = 0; i < number_of_bars; i++){
         highs_d1[i] = iHigh(Symbol(), PERIOD_D1, number_of_bars - i);
         closes_d1[i] = iClose(Symbol(), PERIOD_D1, number_of_bars - i);
         opens_d1[i] = iOpen(Symbol(), PERIOD_D1, number_of_bars - i);
         lows_d1[i] = iLow(Symbol(), PERIOD_D1, number_of_bars - i);
         times_d1[i] = iTime(Symbol(), PERIOD_D1, number_of_bars - i);
      }
   }
}

//+------------------------------------------------------------------+
//| Sweep + CM function                                              |
//+------------------------------------------------------------------+
void SweepWithCM(ENUM_TIMEFRAMES timeframe_sweep, ENUM_TIMEFRAMES timeframe_cm){
   
   // Initialize arrays to use
   double highs_sweep[];
   double closes_sweep[];
   double opens_sweep[];
   double lows_sweep[];
   double times_sweep[];
   
   double highs_cm[];
   double closes_cm[];
   double opens_cm[];
   double lows_cm[];
   double times_cm[];
   
   // First find out which arrays to search for the sweep
   if (timeframe_sweep == PERIOD_M1){
      ArrayCopy(highs_sweep, highs_m1);
      ArrayCopy(closes_sweep, closes_m1);
      ArrayCopy(opens_sweep, opens_m1);
      ArrayCopy(lows_sweep, lows_m1);
      ArrayCopy(times_sweep, times_m1);
   }
   else if (timeframe_sweep == PERIOD_M15){
      ArrayCopy(highs_sweep, highs_m15);
      ArrayCopy(closes_sweep, closes_m15);
      ArrayCopy(opens_sweep, opens_m15);
      ArrayCopy(lows_sweep, lows_m15);
      ArrayCopy(times_sweep, times_m15);
   }
   else if (timeframe_sweep == PERIOD_M30){
      ArrayCopy(highs_sweep, highs_m30);
      ArrayCopy(closes_sweep, closes_m30);
      ArrayCopy(opens_sweep, opens_m30);
      ArrayCopy(lows_sweep, lows_m30);
      ArrayCopy(times_sweep, times_m30);
   }
   else if (timeframe_sweep == PERIOD_H1){
      ArrayCopy(highs_sweep, highs_h1);
      ArrayCopy(closes_sweep, closes_h1);
      ArrayCopy(opens_sweep, opens_h1);
      ArrayCopy(lows_sweep, lows_h1);
      ArrayCopy(times_sweep, times_h1);
   }
   else if (timeframe_sweep == PERIOD_H4){
      ArrayCopy(highs_sweep, highs_h4);
      ArrayCopy(closes_sweep, closes_h4);
      ArrayCopy(opens_sweep, opens_h4);
      ArrayCopy(lows_sweep, lows_h4);
      ArrayCopy(times_sweep, times_h4);
   }
   else if (timeframe_sweep == PERIOD_D1){
      ArrayCopy(highs_sweep, highs_d1);
      ArrayCopy(closes_sweep, closes_d1);
      ArrayCopy(opens_sweep, opens_d1);
      ArrayCopy(lows_sweep, lows_d1);
      ArrayCopy(times_sweep, times_d1);
   }
   
   // And for the CM
   if (timeframe_cm == PERIOD_M1){
      ArrayCopy(highs_cm, highs_m1);
      ArrayCopy(closes_cm, closes_m1);
      ArrayCopy(opens_cm, opens_m1);
      ArrayCopy(lows_cm, lows_m1);
      ArrayCopy(times_cm, times_m1);
   }
   else if (timeframe_cm == PERIOD_M15){
      ArrayCopy(highs_cm, highs_m15);
      ArrayCopy(closes_cm, closes_m15);
      ArrayCopy(opens_cm, opens_m15);
      ArrayCopy(lows_cm, lows_m15);
      ArrayCopy(times_cm, times_m15);
   }
   else if (timeframe_cm == PERIOD_M30){
      ArrayCopy(highs_cm, highs_m30);
      ArrayCopy(closes_cm, closes_m30);
      ArrayCopy(opens_cm, opens_m30);
      ArrayCopy(lows_cm, lows_m30);
      ArrayCopy(times_cm, times_m30);
   }
   else if (timeframe_cm == PERIOD_H1){
      ArrayCopy(highs_cm, highs_h1);
      ArrayCopy(closes_cm, closes_h1);
      ArrayCopy(opens_cm, opens_h1);
      ArrayCopy(lows_cm, lows_h1);
      ArrayCopy(times_cm, times_h1);
   }
   else if (timeframe_cm == PERIOD_H4){
      ArrayCopy(highs_cm, highs_h4);
      ArrayCopy(closes_cm, closes_h4);
      ArrayCopy(opens_cm, opens_h4);
      ArrayCopy(lows_cm, lows_h4);
      ArrayCopy(times_cm, times_h4);
   }
   else if (timeframe_cm == PERIOD_D1){
      ArrayCopy(highs_cm, highs_d1);
      ArrayCopy(closes_cm, closes_d1);
      ArrayCopy(opens_cm, opens_d1);
      ArrayCopy(lows_cm, lows_d1);
      ArrayCopy(times_cm, times_d1);
   }

   // Loop over candles from left (old) to right (new) on sweep timeframe
   for(int i=1;i < number_of_bars - 1;i++){
   
      // For all swing highs (high higher than highs at each side)
      if(highs_sweep[i] > highs_sweep[i-1] && highs_sweep[i] > highs_sweep[i+1]){
      
         // Store the swing high we are currently looking at
         double swing_high = highs_sweep[i];
         double swing_high_time = times_sweep[i];
            
         // For all candles on the sweep timeframe after this
         for(int j=i;j < number_of_bars;j++){
            
            // If price closes above, abort and scan from next swing high
            if (closes_sweep[j] > swing_high){
               break;
            }
               
            // If not, check if it is a sweep above swing high, on sweep timeframe
            else if(swing_high >= opens_sweep[j] && swing_high >= closes_sweep[j] && highs_sweep[j] > swing_high){
               
               //printf("UpSweep at " + TimeToString(times_sweep[j]) + " after swing high at " + TimeToString(swing_high_time));
               
               // Notify if we want notifications and this is a new sweep
               if (NotifyOnSweep && (j == (number_of_bars - 1))){
                  SendNotification("UpSweep on " + Symbol() + " timeframe " + timeframe_sweep);
               }
               
               // Find highest high on CM timeframe, after swing high on sweep timeframe
               double highest_high_in_sweep = 0;
               int highest_high_in_sweep_index = 0;

               for (int k = 0; k < number_of_bars; k++){
                  if ((highs_cm[k] > highest_high_in_sweep) && (times_cm[k] > swing_high_time)){
                     highest_high_in_sweep = highs_cm[k];
                     highest_high_in_sweep_index = k;
                  }
               }
                  
               //printf("Highest high on CM timeframe after swing high at " + TimeToString(times_cm[highest_high_in_sweep_index]));
               
               // Find last swing low on CM timeframe, between sweep and swing high on sweep timeframe, before highest high on CM timeframe
               int last_swing_low_cm_index = 0;
               for (int k=1; k < number_of_bars-1; k++){
                  // Find swing low on CM timeframe ..                                           between swing high and sweep ..                                     before highest high on CM timeframe
                  if (lows_cm[k] < lows_cm[k-1] && lows_cm[k] < lows_cm[k+1] && times_cm[k] > swing_high_time && times_cm[k] <= times_sweep[j] && times_cm[k] < times_cm[highest_high_in_sweep_index]){
                     last_swing_low_cm_index = k;
                  }
               }
                  
               //printf("Last swing low between swing high and sweep, before highest high at " + TimeToString(times_cm[last_swing_low_cm_index]));
                  
                  
               // Check if we close below this swing low on CM timeframe, after sweep on CM timeframe, 
               for (int l = last_swing_low_cm_index; l < number_of_bars; l++){
                  if (closes_cm[l] < lows_cm[last_swing_low_cm_index]){
                     if (times_cm[l] > times_cm[highest_high_in_sweep_index]){
                        if (NotifyOnCM && (j == (number_of_bars - 1))){
                           SendNotification("UpSweep + CM on " + Symbol() + " sweep_timeframe " + timeframe_sweep + "m cm timeframe: " + timeframe_cm + "m");  
                        }
                        //printf("CM, closing below swing low at " + TimeToString(times_cm[l]));
                     }
                  }
               }
            }
         }
      }
   }   
   
   // Repeat everything for DownSweep
   
   // Loop over candles from left (old) to right (new) on sweep timeframe
   for(int i=1;i < number_of_bars - 1;i++){
   
      // For all swing lows (lows lower than lows at each side)
      if(lows_sweep[i] < lows_sweep[i-1] && lows_sweep[i] < lows_sweep[i+1]){
      
         // Store the swing low we are currently looking at
         double swing_low = lows_sweep[i];
         double swing_low_time = times_sweep[i];
            
         // For all candles on the sweep timeframe after this
         for(int j=i;j < number_of_bars;j++){
            
            // If price closes below, abort and scan from next swing high
            if (closes_sweep[j] < swing_low){
               break;
            }
               
            // If not, check if it is a sweep below swing low, on sweep timeframe
            else if(swing_low <= opens_sweep[j] && swing_low <= closes_sweep[j] && lows_sweep[j] < swing_low){
               
               //printf("DownSweep at " + TimeToString(times_sweep[j]) + " after swing low at " + TimeToString(swing_low_time));
               
               // Notify if we want notifications and this is a new sweep
               if (NotifyOnSweep && (j == (number_of_bars - 1))){
                  SendNotification("DownSweep on " + Symbol() + " timeframe " + timeframe_sweep);
               }
               
               // Find lowest low on CM timeframe, after swing low on sweep timeframe
               double lowest_low_in_sweep = 99999999; // Need to use some arbitrary, large number here
               int lowest_low_in_sweep_index = 0;

               for (int k = 1; k < number_of_bars; k++){
                  if ((lows_cm[k] < lowest_low_in_sweep) && (times_cm[k] > swing_low_time)){
                     lowest_low_in_sweep = lows_cm[k];
                     lowest_low_in_sweep_index = k;
                  }
               }
                  
               //printf("Lowest low on CM timeframe after swing low at " + TimeToString(times_cm[lowest_low_in_sweep_index]));
               
               // Find last swing high on CM timeframe, between sweep and swing low on sweep timeframe, before lowest low on CM timeframe
               int last_swing_high_cm_index = 0;
               for (int k=1; k < number_of_bars-1; k++){
                  // Find swing high on CM timeframe ..                                           between swing high and sweep ..                                     before highest high on CM timeframe
                  if (highs_cm[k] > highs_cm[k-1] && highs_cm[k] > highs_cm[k+1] && times_cm[k] > swing_low_time && times_cm[k] <= times_sweep[j] && times_cm[k] < times_cm[lowest_low_in_sweep_index]){
                     last_swing_high_cm_index = k;
                  }
               }
                  
               //printf("Last swing high between swing low and sweep, before lowest low at " + TimeToString(times_cm[last_swing_high_cm_index]));
                  
                  
               // Check if we close above this swing high on CM timeframe, after sweep on CM timeframe, 
               for (int l = last_swing_high_cm_index; l < number_of_bars; l++){
                  if (closes_cm[l] > highs_cm[last_swing_high_cm_index]){
                     if (times_cm[l] > times_cm[lowest_low_in_sweep_index]){
                        if (NotifyOnCM && (j == (number_of_bars - 1))){
                           SendNotification("DownSweep + CM on " + Symbol() + " sweep_timeframe " + timeframe_sweep + "m cm timeframe: " + timeframe_cm + "m");  
                        }
                        //printf("CM, closing above swing high at " + TimeToString(times_cm[l]));
                     }
                  }
               }
            }
         }
      }
   }
   
}

//+------------------------------------------------------------------+
//| Update candle times                                              |
//+------------------------------------------------------------------+
void UpdateCandleTimes(bool Update_m1, bool Update_m15, bool Update_m30, bool Update_h1, bool Update_h4, bool Update_d1){
   if (Update_m1){
      CandleTime_m1 = iTime(Symbol(), PERIOD_M1, 0);
   }
   if (Update_m15){
      CandleTime_m15 = iTime(Symbol(), PERIOD_M15, 0);
   }
   if (Update_m30){
      CandleTime_m30 = iTime(Symbol(), PERIOD_M30, 0);
   }
   if (Update_h1){
      CandleTime_h1 = iTime(Symbol(), PERIOD_H1, 0);
   }
   if (Update_h4){
      CandleTime_h4 = iTime(Symbol(), PERIOD_H4, 0);
   }
   if (Update_d1){
      CandleTime_d1 = iTime(Symbol(), PERIOD_D1, 0);
   }
}

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
   // Make sure changing timeframe on chart does not run OnInit again
   if (UninitializeReason() == REASON_CHARTCHANGE) {
      return(INIT_SUCCEEDED);
   }
   
   // Obtain initial candle info
   SetupArrays();
   
   // Store datetime
   CandleTime_m1 = iTime(Symbol(), PERIOD_M1, 0);
   CandleTime_m15 = iTime(Symbol(), PERIOD_M15, 0);
   CandleTime_m30 = iTime(Symbol(), PERIOD_M30, 0);
   CandleTime_h1 = iTime(Symbol(), PERIOD_H1, 0);
   CandleTime_h4 = iTime(Symbol(), PERIOD_H4, 0);
   CandleTime_d1 = iTime(Symbol(), PERIOD_D1, 0);
   
   // Run initial sweep + cm search
   /*
   if (sweep_h4_cm_m15 == True){
      SweepWithCM(PERIOD_H4, PERIOD_M15);
   }
   
   if (sweep_h1_cm_m15 == True){
      SweepWithCM(PERIOD_H1, PERIOD_M15);
   }
   */
   
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  
   // Make sure changing timeframe on chart does not run OnDeinit again
   if (UninitializeReason() == REASON_CHARTCHANGE) {
      return;
   }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   
   // Variables to see if we need to update candles
   bool NewCandle_m1 = False;
   bool NewCandle_m15 = False;
   bool NewCandle_m30 = False;
   bool NewCandle_h1 = False;
   bool NewCandle_h4 = False;
   bool NewCandle_d1 = False;
   
   // Check which candles should be updated
   if (CandleTime_d1 != iTime(Symbol(), PERIOD_D1, 0)){
      NewCandle_d1 = True;
      NewCandle_h4 = True;
      NewCandle_h1 = True;
      NewCandle_m30 = True;
      NewCandle_m15 = True;
      NewCandle_m1 = True;
   }
   else if (CandleTime_h4 != iTime(Symbol(), PERIOD_H4, 0)){
      NewCandle_d1 = False;
      NewCandle_h4 = True;
      NewCandle_h1 = True;
      NewCandle_m30 = True;
      NewCandle_m15 = True;
      NewCandle_m1 = True;
   }
   else if (CandleTime_h1 != iTime(Symbol(), PERIOD_H1, 0)){
      NewCandle_d1 = False;
      NewCandle_h4 = False;
      NewCandle_h1 = True;
      NewCandle_m30 = True;
      NewCandle_m15 = True;
      NewCandle_m1 = True;
   }
   else if (CandleTime_m30 != iTime(Symbol(), PERIOD_M30, 0)){
      NewCandle_d1 = False;
      NewCandle_h4 = False;
      NewCandle_h1 = False;
      NewCandle_m30 = True;
      NewCandle_m15 = True;
      NewCandle_m1 = True;
   }
   else if (CandleTime_m15 != iTime(Symbol(), PERIOD_M15, 0)){
      NewCandle_d1 = False;
      NewCandle_h4 = False;
      NewCandle_h1 = False;
      NewCandle_m30 = False;
      NewCandle_m15 = True;
      NewCandle_m1 = True;
   }
   else if (CandleTime_m1 != iTime(Symbol(), PERIOD_M1, 0)){
      NewCandle_d1 = False;
      NewCandle_h4 = False;
      NewCandle_h1 = False;
      NewCandle_m30 = False;
      NewCandle_m15 = False;
      NewCandle_m1 = True;
   }
   else{
      return;
   }
   
   // Update candle times according to checks above
   UpdateCandleTimes(NewCandle_m1, NewCandle_m15, NewCandle_m30, NewCandle_h1, NewCandle_h4, NewCandle_d1);
   
   // Update the arrays we need to update
   UpdateArrays(NewCandle_m1,NewCandle_m15, NewCandle_m30, NewCandle_h1, NewCandle_h4, NewCandle_d1);

   // If we have new data for the combination we want to run, look for sweep + cm now
   if (sweep_h4_cm_m15 == True){
      if (NewCandle_m15){
         SweepWithCM(PERIOD_H4, PERIOD_M15);
      }
   }
   
   if (sweep_h1_cm_m15 == True){
      if (NewCandle_m15){
         SweepWithCM(PERIOD_H1, PERIOD_M15);
      }
   }
   
   
  }
//+------------------------------------------------------------------+
