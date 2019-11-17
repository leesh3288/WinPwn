# Fastcalc-hardened

| Task             | Fastcalc-hardened         |
|------------------|---------------------------|
| Competition      | [CONFidence CTF 2017](https://ctftime.org/event/434)       |
| Location				 | Krakow, Poland					   |
| Category         | Software exploitation     |
| Platform         | Windows x86               |
| Scoring          | 500 pts (hard)						 |
| Number of solves | 3 out of 22 teams         |

## Description

Perhaps you still remember the "Fastcalc" challenge from this year's CONFidence Teaser (see the fastcalc.exe file). Well, we have taken a careful look at the code and your feedback, and think we've fixed the issues that made it so easily exploitable. Most notably, one of the problems was that an innocent input (see [bad_input.txt](task/bad_input.txt)) would sometimes cause the program to return unexpected results. Now that it is resolved, the program surely cannot be pwned anymore? :-)

```AppJailLauncher.exe /key:flag.txt /port:12345 /timeout:30 fastcalc-hardened.exe```