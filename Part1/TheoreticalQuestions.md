 ## Explain what is the mathematical criterion that ensures no ISI.

 The mathematical criterion that ensures no Intersymbol Interference (ISI) is the fulfillment of the Nyquist criterion for zero ISI. 
 This criterion is essential in digital communication systems to avoid the overlap of different signal elements (symbols), which can lead to 
 errors in signal interpretation.
 
Nyquist criterion for zero ISI is met when the channel's impulse response has zero values at multiples of the symbol 
interval, except at zero. This ensures that each symbol in the transmitted signal is only affected by its own value and not by the 
values of adjacent symbols, thus preventing ISI.

- #### Nyquist Rate:

    The Nyquist rate is twice the bandwidth of the signal. According to the Nyquist theorem, a continuous signal with bandwidth B Hz must be
    sampled at least at a rate of 2B samples per second to avoid aliasing.

- #### Nyquist Criterion for Zero ISI:

   This criterion focuses on the shape of the impulse response of the transmission channel (or filter). For zero ISI, the impulse response
   h(t) of the channel must satisfy the condition that its samples at the symbol rate T (where  ```T = 1 / 2B``` seconds)

- #### Raised Cosine Filter:
  
   A practical implementation of the Nyquist criterion is the raised cosine filter, which offers control over the bandwidth and the
   roll-off factor. This filter effectively shapes the signal in such a way that the zero crossings align with the symbol intervals,
   thereby eliminating ISI.
   ![image](https://github.com/meh-land/Digital_Comm2_Proj/assets/79084467/e9d3b0ae-fb4e-4597-bd61-06b532a68516)



