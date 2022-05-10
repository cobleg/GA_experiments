# Problem statement
Adoption of new technology (e.g. electric vehicles, solar power systems, behind-the-meter battery systems) invariably tracks along a non-linear time path. Diffusion models in the marketing science literature typically specify [sigmoid functions](https://en.wikipedia.org/wiki/Sigmoid_function) such as the [Bass Model](https://en.wikipedia.org/wiki/Bass_diffusion_model). However, when applying diffusion models to real-world data, we typically encounter the problem of insufficient flexibility in the sigmoid function.

More complex variants of sigmoid functions are then required, which in turn, are more difficult to calibrate. However, recent technical papers demonstrate the use of genetic algorithms to quickly calibrate more complex sigmoid variations. One example is:

[Shakshi Singhal, Adarsh Anand, Ompal Singh (2020). Studying dynamic market size-based adoption modeling & product diffusion
under stochastic environment. *Technological Forecasting & Social Change* 161 (2020) 120285 ](https://www.sciencedirect.com/science/article/abs/pii/S0040162520311112?via%3Dihub)

# Approach
In this project, I'm testing various genetic algorithms to test the claims and explore a workable solution using the GA library in R
