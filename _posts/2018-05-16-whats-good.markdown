---
layout: slides
title: What's Good?
tags:
 - tech
 - unions
 - presentation
---

*This is the transcription of a presentation I gave at [Isle of Ruby 2018][ior]. I've worked on it a little since then,
amending the text to suit the article format.*

*If you're a conference organiser and you'd like me to present on this topic again, please [let me know](mailto:joe@corcoran.online).*

[ior]: https://2018.isleofruby.org

[^boot]: [Interview with Jacob Thornton](https://www.theframeworkproject.com/interviews/jacob-thornton), _The Framework Project_ (2018).
[^pg]: Paul Graham, [_Frighteningly Ambitious Startup Ideas_](http://paulgraham.com/ambitious.html) (2012).
[^plan1]: Lucas Aerospace Combine Shop Steward Committee, _Corporate Plan_ (1976), p. 7.
[^ou1]: Open University, _The Story of the Lucas Aerospace Shop Stewards Alternative Corporate Plan_ (1978).
[^plan2]: Lucas Aerospace Combine Shop Steward Committee, _Corporate Plan_ (1976), p. 7.
[^wainwright1]: Wainwright & Elliott, _The Lucas Plan: A New Trade Unionism in the Making?_, (London, Allison & Busby, 1982), p. 10.
[^plan3]: Lucas Aerospace Combine Shop Steward Committee, _Corporate Plan_, p. 8.
[^plan4]: Ibid.
[^leguin]: Ursula K. Le Guin, _Dancing at the Edge of the World_, (New York City, Grove Press, 1989).

<div class="slide">
  <img src="/static/images/whats-good/1.png" title="Slide number 1">
  <p>This is a talk about innovation. About good and bad; the things we can influence and the things we can't. Mostly, it's about imagining our future.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/4.png" title="Slide number 4">
  <p><em>[Silence]</em></p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/5.png" title="Slide number 5">
  <p>What do you think of when I say "good software development"? You don't have to shout anything out, just think about it for a second.</p>

  <p>My mind immediately jumps to "good practice", which leads me straight to thinking about design patterns, and the kind of advice that gets passed around between software developers.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/6-7-8.png" title="Slide number 6">
  <p>These are some examples of software advice; they're particularly common in the Ruby world.</p>

  <p>Don't Repeat Yourself (DRY), meaning to favour reusable abstractions over repetitive code.</p>

  <p>You Ain't Gonna Need It (YAGNI), meaning don't write code speculatively and give yourself the burden of maintaining something you probably won't need.</p>

  <p>Not Invented Here (NIH) – not so much a piece of advice but a supposed syndrome that we should avoid – meaning don't write your own version of something that already exists for you to reuse.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/9.png" title="Slide number 9">
  <p>Convention over configuration, meaning to favour software that comes with strong conventions over software that is highly configurable but inconsistent across usage.</p>
  <p>This is my most hated piece of advice in software development. Sometimes it really is applicable &#8212; for instance, I dont want to decide on a directory structure every time I build a new application or library &#8212; but often it's an excuse for the loudest people in the virtual room to push their opinions on you, while you look around nervously for the exit.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/10.png" title="Slide number 10">
  <p>We build, more or less, interfaces (web, API, mobile app) to databases. I think this describes a very large percentage of the startups that I know of. This isn't to say that there is zero innovation in the industry, or that there is no difference from one company to the next &#8212; just significantly less than we've told ourselves. This great similarity informs what we think of as good practice.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/11.png" title="Slide number 11">
  <p>Bootstrap is a website templating system made by developers at Twitter and released as open source software. It helps people build websites very quickly.</p>
  
  <p>Bootstrap helps new learners, and junior developers too &#8212; it gives them advice that they can take with them and use on future projects with no templating system.</p>
  
  <p>Not to mention that there's also a big cognitive benefit for users when they know where on the page to find things and what they will probably look like. Websites have a shared lexicon.</p>
  
  <p>Bootstrap has been immensely useful to many people. And still, its original developers have mixed feelings about the results of the project.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/12.png" title="Slide number 12">
  <p>At one point, Bootstrap was so commonly used that it became very obvious when a site was built with it. People became familiar with the (actually very good) page components, button styles and so on.</p>
  
  <p markdown="1">In an interview, one of the original developers of Bootstrap, Jacob Thornton, said he considers Bootstrap to be "the complete and total homogenization of the web".[^boot] Of course that's an overstatement, and he acknowledges the good aspects of the project too.</p>
  
  <p>But people did begin to feel uncomfortable with Bootstrap's prevalence and designers and developers started to rebel. Either people got better at disguising their use of Bootstrap, or they stopped using it on new projects, but the occurrences of that bare Bootstrap UI feeling in the wild seem to have slowed down.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/14.png" title="Slide number 14">
  <p>In the spirit of Anglophone pseuds who jump at the chance to wedge a German noun into their work to make themselves sound well-read, here's one from me: <em>Einschränkung</em>. It means limitation, restriction, confinement.</p>

  <p>I feel this applies to some of the work we do at tech companies. It might sound alien given the standard rhetoric of the industry &#8212; innovation, progress, changing the world with code &#8212; but let me explain.</p>

  <p>What I mean is the restrictive feeling created by the constant advice that you should reuse what already exists, that practically everything you do is a solved problem. That you don't have agency in what you want to build.</p>

  <p>As with most advice, it's occasionally applicable. Writing your own cryptographic hashing algorithm just to build a password authentication system is a waste of your time.</p>

  <p>Shared experience and learning from each other are great too, but when we take this kind of advice we should at least pause for thought. What are the limits imposed on our work? Are we building something worthwhile at all?</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/15.png" title="Slide number 15">
  <p markdown="1">In 2012, famous venture capitalist and creator of the orange website, Paul Graham, decided that email was no longer fit for purpose and needed to be replaced. For him, email had become a to-do list that was unmanageable.[^pg]</p>
  
  <p>In the next few years, many new email clients were released, catering specifically to this type of email use. Triaging huge inboxes, marking emails as to-do list tasks to resurface later as reminders.</p>
  
  <p>Individuals and small teams were very keen to show off their innovative approach to solving Paul Graham's personal problem. I can't prove that they only did it for him, of course, but given his influence on the tech scene and people's eagerness to chase venture capital, it's easy to make the connection.</p>
  
  <p>This to me is not innovation but a failure of imagination. Most people don't have the problem of receiving thousands of emails a day. If you do, you're likely to be, relatively speaking, one of the richest people on the planet.</p>
  
  <p>I don't doubt that some of the solutions to this problem were novel at the micro level – building an old-fashioned email client is in itself a huge undertaking, after all – but at the macro level, they were addressing a rich guy's personal gripe. This is also <em>Einschränkung</em>; the limitation of our imagination via accepted industry practice.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/16.png" title="Slide number 16">
  <p>I think that when we focus on our work, within the confines somebody else sets for us, not only do we bore ourselves, we also fail to understand how the things we build fit into society.</p>
  
  <p>In the past I have been the kind of developer who would get so excited to use a new programming language or a new framework that I didn't give a thought to what I was building, or why.</p>
  
  <p>Sometimes the products and services we build even harm people, and we don't look outside of our confines to notice.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/17.png" title="Slide number 17">
  <p>In the past year I've read this book, <em>In Defence of Serendipity</em>, a handful of times. I keep coming back to it, because I think it has so much to offer to people with creative jobs.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/18.png" title="Slide number 18">
  <p>Throughout the book, Sebastian Olma uses the term <em>Pharmakon</em>. It's a term from French philosopher Bernard Stiegel. The idea is that when we build a new technology, we are creating both a potential antidote to our present condition, and a potential poison.</p>
  
  <p>There are good and bad implementations of every idea. The things we build can either help or harm; often they do both at the same time.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/20.png" title="Slide number 20">
  <p>Social media changed my life. There's no doubt about it. I wouldn't be here giving this presentation without it. Meeting people, learning together with them, developing a strange shared language that only exists in my virtual circle &#8212; these things have shaped the person that I am today.</p>
  
  <p>I'm sure many of you feel the same. Being able to reach people in other cities, other countries, other cultures is really powerful. My worldview has changed immeasurably through social media.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/21.png" title="Slide number 21">
  <p>At the same time, social media is toxic. I believe irreparably so. It enables people to be vile to each other, all day every day.</p>
  
  <p>Design and development decisions affect our behaviour and inform the way in which we communicate with each other.</p>
  
  <p>Arguments erupt out of the terseness of the discourse, and bad faith interpretations of text from people we've never met are commonplace.</p>
  
  <p>You could say I <em>need</em> Twitter, but I also hate it and it's poisonous and I wish it would die. It's a <em>Pharmakon</em>.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/22.png" title="Slide number 22">
  <p>What's interesting about the Facebook and Cambridge Analytica story to me is not Cambridge Analytica's involvement – there have been shady political intelligence companies for many years, and they have operated disgracefully yet effectively without a need for big data.</p>
  
  <p>What's really striking is that the issue stems from what are effectively standard industry practices of lax handling of user data, and a platform encouraging a third-party app ecosystem to grow.</p>
  
  <p>What could a Facebook employee really do in this situation? This kind of thing is simply what tech companies do &#8212; it's taken as read. They can protest internally &#8212; I have no doubt that many of them have &#8212; but if the business itself rests on a socially harmful practice, Facebook employees are more likely to try and focus on improving micro aspects of the company. They are <em>eingeschränkt</em> &#8212; forced to concentrate on the minutiae of the technology they work on, and maybe the internals of the company (its structure, its culture, the diversity of its composition etc.), but never the poison of the <em>Pharmakon</em> they have released into society.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/24.png" title="Slide number 24">
  <p>As a worker in a tech company, there are clear areas which are open to your influence, depending on your role. As a software developer, I can make suggestions to my team about the design of an application, or the design of our infrastructure and how our many applications interact with each other, and we'll talk about these things. Sometimes my suggestions are even accepted! We talk things through, and we reach decisions that satisfy the team.</p>
  
  <p>How does a tech worker influence what the company produces? Or the role of the company in society? Or the effect their product has on its users? That's where things get fuzzy.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/25.png" title="Slide number 25">
  <p>You could quit. People do. I've quit many times. In 12 years as a software developer, I've had a new job on average every two years. Sometimes out of boredom. Sometimes because I didn't like what the company was doing. My place in the world, working for that particular company, didn't sit well with me.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/27.png" title="Slide number 27">
  <p>You could consider that your involvement with profit-seeking companies is done, and try to make a move into the public sector, or into a "social enterprise" – a company that seeks to bring about social good via regular market-driven business practices. There are lots of these companies around now that people start to consider the ethical implications of the web.</p>
  
  <p>There's a common misapplication of technology in these circles though. The temptation is to immediately assume that because one has a certain skillset, ones skills can be directly and quickly applied to a social problem.</p>
  
  <p>Olma: "In many cases, the understanding of social innovation is such that the 'social' in social innovation is provided by a real or imaginary social problem, while the 'innovation' part comes from the application of a new – often digital, web or social media based – piece of technology."</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/28.png" title="Slide number 28">
  <p>Olma goes on to provide the example of an entry in the 2014 Bloomberg Challenge – a social innovation award from Michael Bloomberg (former mayor of New York City). A team from Amsterdam decided to respond to the problem of rising unemployment among graduates from technical colleges by developing an online gaming platform that would help them develop their skills. Whoever wins the game gets access to an offline coaching program connecting them to industry professionals.</p>
  
  <p>Olma lambasts this approach as both degrading to the students, to have them compete their way into a decent job opportunity, but also for depoliticising a societal issue, and I have to agree. The issue of rising unemployment is not a design challenge for software engineers.</p>
  
  <p>None of this is to say that social enterprises cannot achieve good things – and I realise it can sound mean-spirited to make this argument – but whenever I've thought of pulling the emergency brake and quitting a tech job (please remember my disclaimer from earlier), this kind of careless application of technology to a fundamentally non-technological problem has always made me sceptical.</p>
  
  <p>(For anyone unsure about the image, that's Alan Sugar, the host of The Apprentice in the UK. He's horrible, but believe it or not he was preferable to the US host when I was picking photos for this presentation.)</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/29.png" title="Slide number 29">
  <p>Quitting a company and moving on solves the problem of personal unhappiness – maybe only temporarily, but it does. If you're really unhappy in your work and you can afford to quit, you should quit. It's good for you.</p>
  
  <p>What quitting doesn't change is the direction in which the industry is heading. To do that, I believe we need collective action.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/30.png" title="Slide number 30">
  <p>These stats are from the US. Union representation in computing and mathematics is the lowest of all fields at 4.9%. I imagine a similar picture for most of the countries we conference attendees live in. My trade union has a large IT branch, but it mostly consists of workers from big firms like Siemens.</p>
  
  <p>We don't have many examples of collective action to look upon for inspiration in this industry. The conditions of employment, while comfortable and well-paid, have made it almost impossible to organise along the same lines that trades unions have done historically.</p>
  
  <p>Along with the ping-pong tables and the bean bags and the imported bottles of Club-Mate, software workers have high salaries, switch jobs frequently, may work on globally-distributed teams, and the companies themselves are often gone within a few years after their moonshot fails. This all adds up to a working environment which is highly resistant to traditional forms of collective action.</p>

  <p>I am however very interested to see what happens with Lanetix in San Francisco, a company which recently fired all of its software engineers explicitly because they tried to join NewsGuild-CWA (a communication workers' union).</p>
  
  <p>Let's take a look at some remarkable examples of disputes from other industries and think about how our own industry compares.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/31.png" title="Slide number 31">
  <p>From left to right, that's Bob Fulton, John Keenan and Robert Somerville.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/32.png" title="Slide number 32">
  <p>In 1974, a shipment of engines arrived at Rolls-Royce for servicing in East Kilbride, Scotland. Bob Fulton, the man on the left, recognised them as the engines used in war planes during the military coup in Chile, in September of the previous year.</p>
  
  <p>On the day he realised this, he refused to service the engines. Some of the people in the engineering union had joined the International Brigades to fight Franco in Spain. Some of them had fought in WW2.</p>
  
  <p>Bob told his colleagues where the engines had come from, and soon enough the rest of the workers also refused to touch the engines.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/34.png" title="Slide number 34">
  <p>The engines were eventually boxed and taken outside to the yard. They stood unserviced, rusting in the Scottish weather, for years. In 1978 they were taken from Scotland in the middle of the night and returned to Chile, unserviced. They had hindered Pinochet's air force for years.</p>
  
  <p>In relation to our industry, what is striking to me about this story is that we so rarely have simple, direct contact with the ill effects of our work. The decision by the Rolls-Royce workers to refuse to service those engines was very brave, and risky, but it was also quite morally straightforward. There was nothing good about those engines returning to Chile. The relationships between the good and bad effects of our industry are complex.</p>
  
  <p>It was normal in the 1970s for engineering companies to rely on multiple suppliers for machine parts, for example, but interdependency in the age of <em>Software as a Service</em> seems significantly more entangled.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/35.png" title="Slide number 35">
  <p>There's a new documentary film about the engineers from East Kilbride that is currently being screened in various places. It's called <em>¡Nae Pasaran!</em></p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/36.png" title="Slide number 36">
  <p>These are the women machinists of the Ford car factories in Dagenham, in London and Halewood, near Liverpool.</p>
  
  <p>In 1967, Ford implemented a new pay grading system for all workers paid by the hour. All women were placed on the lowest grade, as they were considered unskilled workers, and within that grade were paid around 15% less than the men.</p>
  
  <p>In 1968 the women went on strike for three weeks, after which Ford conceded that the women would get an immediate pay rise, and <em>eventual</em> parity with men of the same pay grade.</p>
  
  <p>The strike is now considered the main force behind the Equal Pay Act, which became law in the UK in 1975. There is a film about the 1968 strike too – it's called Made in Dagenham.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/37.png" title="Slide number 37">
  <p>The fact that the women were placed on the lowest, unskilled pay grade by default was not addressed by the outcome of the 1968 strike.</p>
  
  <p>This really hurt them. Pay was not the only issue. Ford just refused to accept the idea that the work these women did was skilled, important work.</p>
  
  <p>By 1980, the women had started to organise against their insulting pay grade. After four years of planning, they realised that they were not going to get the help they needed from their union, nor from their male colleagues at Ford.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/38.png" title="Slide number 38">
  <p>The women been insulted and demoralised for decades, and went on strike again over Christmas in 1984. The strike resulted in thousands of layoffs, and eventually ended when Ford agreed to an independent inquiry into the pay grading system. The women achieved their move to a skilled pay grade in 1985.</p>
  
  <p>There are two lessons in this story for us, I think.</p>
  
  <p>The first lesson: I was born in 1984, when the women at Ford were planning their second strike. That the gender pay gap is still an issue across every industry in 2018, is a disgrace. It's our responsibility to address this. The story of the women at Ford getting no support from their union nor from the men at the factories is bitter because it still happens today.</p>
  
  <p>The second: can you image the strength required to persist with an issue like this over eighteen years? From 1967 to 1985 these women took their knocks from every side, and refused to back down. Sometimes I wonder if we have this kind of resolve. We give up fairly easily by comparison, I think.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/39.png" title="Slide number 39">
  <p>From 1960 to 1975, the aerospace industry in the UK lost almost 100,000 jobs.</p>
  
  <p>Prime Minister Harold Wilson gave a speech in 1963 stating that Britain needed to be remade in the "white heat of technology". What he meant was a shift from manual work to research and development, and the "rationalisation" of large manufacturing companies. Rationalisation being a term for corporate restructuring that would usually be accompanied by job losses.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/40.png" title="Slide number 40">
  <p>Shop stewards at Lucas Aerospace anticipated mass redundancies, and formed a combine – a committee featuring members from various Lucas factories around the UK – to make a plan, both to avoid layoffs <em>and</em> to change what the company produced.</p>
  
  <p>Lucas was, among other things, a manufacturer of military aircraft components – like Rolls-Royce.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/41.png" title="Slide number 41">
  <p>This is a quote from the Financial Times back then. They called it "one of the most ambitious and radical alternative plans drawn up for a company by its workers".</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/42.png" title="Slide number 42">
  <p markdown="1">This is a quote from the intro to the Plan, published in January 1976, which demonstrates the spirit of what the Lucas workers hoped to achieve.[^plan1]</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/43.png" title="Slide number 43">
  <p>This is Mike Cooley, one of the main organisers of the Lucas Combine. He worked as a design engineer.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/44.png" title="Slide number 44">
  <p markdown="1">This quote is a from a "town hall" meeting of Lucas employees in 1975.[^ou1] Cooley is trying to explain that the Plan has moral ambitions as well as protecting jobs.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/45.png" title="Slide number 45">
  <p markdown="1">The conversation goes further into the social weaknesses of profit-driven company planning.[^ou1] I love this quote because it's a clear assertion of moral, social good over market logic. This was directed at another Lucas employee too, so you can see the Combine had to convince fellow workers to believe in the possibilities of the Plan just as much as they had to make the case to the Lucas owners.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/46.png" title="Slide number 46">
  <p markdown="1">Here's another line from the intro to the Plan.[^plan2]</p>
  
  <p>One of the many alternative products the Combine wanted Lucas to produce was energy efficient heating components.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/47.png" title="Slide number 47">
  <p>The Lucas Plan was over a thousand pages long and based on extensive research into potential new products, social need, and a thorough assessment of the skills of the Lucas engineers.</p>
  
  <p>They even went so far as to test prototypes of a "road-rail vehicle" – a new form of public transport.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/48.png" title="Slide number 48">
  <p>Look at it! Driving on the tracks!</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/49.png" title="Slide number 49">
  <p markdown="1">The Lucas Combine wrestled with the question of social usefulness, not only in terms of what they could build, but <em>how</em> they might build it.[^wainwright1] They planned for ethical provision of raw materials, minimising waste, and manageable working conditions in the factories.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/50.png" title="Slide number 50">
  <p markdown="1">They saw the social problems caused by the products they built, and they wanted to end those problems and in doing so, reinvent the company as a force for good.[^plan3]</p>
  
  <p>The engineers were tired of putting their skills towards building socially useless or damaging products. They were experiencing <em>Einschränkung</em> and they'd had enough!</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/51.png" title="Slide number 51">
  <p markdown="1">They described their <em>profound responsibility</em> to question the industry and how it worked.[^plan4]</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/52.png" title="Slide number 52">
  <p>The Plan, sadly, was rejected by Lucas management. It's arguable the owners of Lucas were never much bothered by the moral argument against arms manuafacture in general, but this decision was also made despite clear signs that the industry was heading for lean times. Cuts to government defence budgets were acceptable to the public around that time, and the market for war planes was shrinking.</p>
  
  <p>The efforts of the Lucas Combine, though, remain an inspiration.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/53.png" title="Slide number 53">
  <p>So what are the lessons for us here?</p>

  <p>The fact is, we always have a choice in what we build and how we build it. The consequences of us asserting our right to that choice might be conflict at work, or changing jobs, and depending on circumstances not everyone can bear those consequences equally. But we always have that choice and we shouldn't forget it.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/54.png" title="Slide number 54">
  <p>The industry we work in is full of highly skilled people. We should not need to confine our innovation to the micro level – it's time we applied it to our role in society.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/55.png" title="Slide number 55">
  <p>The things we are capable of could be put to incredible social use if we weren't limited to producing only what is acceptable to business owners and venture capital.</p>

  <p>We should also be prepared for the prospect that what society needs the most right now is not incredibly new and exciting, and that our skills might be needed in ways we haven't yet imagined. From Wainwright and Elliott's book on the Lucas Plan:</p>

  <blockquote>"The principles of socially useful production and planning for social need do not necessarily mean alternative products."</blockquote>
</div>

<div class="slide">
  <img src="/static/images/whats-good/56.png" title="Slide number 56">
  <p>The value of what we produce is for society to decide.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/57.png" title="Slide number 57">
  <p>If we are ever to shift this industry in a new direction, we need <em>new forms of collective action</em> that allow us to break out of our current modes of operation. This won't be handed down to us by benevolent VCs or founders of social enterprises.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/58.png" title="Slide number 58">
  <p>For the rest of this weekend I'm going to be hanging around at this great conference, attending all the other talks, and I'd also like to talk with you.</p>
  
  <p>Our working conditions are significantly different to those of the Lucas Aerospace engineers in the mid-1970s. At the same time, companies like Amazon and Google are making the opposite moves to those the Lucas engineers wanted to make – moving into research and development of military technology because it's so lucrative.</p>
  
  <p>But I believe we can choose to build socially useful things, in a socially responsible way. It's just a question of how we get there. We should feel that same <em>profound responsibility</em> as the Lucas engineers did.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/59.png" title="Slide number 59">
  <p>I want to close with a quote from Ursula K. Le Guin, who died earlier this year. It's from an essay written in 1982, entitled <em>A Non-Euclidean View of California as a Cold Place to Be</em>.</p>
</div>

<div class="slide">
  <img src="/static/images/whats-good/60.png" title="Slide number 60">
  <p>In this essay Le Guin is grappling with the idea of utopia, and in this particular section she is thinking about the anthropologist Claude Lévi-Strauss and his concept of "hot" and "cold" societies; the hot ones being the societies with a rapid rate of technological change. She says:</p>
  
  <blockquote><span markdown="1">"One need not smash one's typewriter and go bomb the laundromat, after all, because one has lost faith in the continuous advance of technology as the way towards utopia. Technology remains, in itself, an endless creative source." [^leguin]</span></blockquote>
</div>

<div class="slide">
  <img src="/static/images/whats-good/61.png" title="Slide number 61">
  <blockquote><span markdown="1">"I only wish that I could follow Lévi-Strauss in seeing it as leading from the civilization that turns men into machines to 'the civilization that will turn machines into men'. But I cannot." [^leguin]</span></blockquote>
</div>

<div class="slide">
  <img src="/static/images/whats-good/62.png" title="Slide number 62">
  <blockquote><span markdown="1">"I do not see how even the most ethereal technologies promised by electronics and information theory can offer more than the promise of the simplest tool: to make life materially easier, to enrich us." [^leguin]</span></blockquote>
</div>

<div class="image-credits" markdown="1">
  Image credits: [Repeater Books](https://repeaterbooks.com/product/in-defence-of-serendipity/), [Simon Harrod](https://flickr.com/photos/sidibousaid/7064590663), [@jmsclee](https://twitter.com/jmsclee/status/975784464696643584), [Stuart Franklin](https://twitter.com/britcultarchive/status/934344421646176256), [¡Nae Pasaran!](https://vimeo.com/182246588), [Red Pepper](https://www.redpepper.org.uk/finally-making-the-grade/), [@RadicalEssex](https://twitter.com/radicalessex/status/839480706229276674), [Open University](https://www.youtube.com/watch?v=0pgQqfpub-c), [Pip R. Lagenta](https://www.flickr.com/photos/pip_r_lagenta/3386209645/), [Gorthian](https://commons.wikimedia.org/wiki/File:Ursula_K_Le_Guin.JPG)
</div>
