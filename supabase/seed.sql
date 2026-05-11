-- Profile
insert into profile (name, headline, bio, location, linkedin_url, email) values (
  'Alison Charles',
  'Director of Product Marketing',
  'B2B product marketer with 15 years of experience, including six years as a hands-on player-coach. I specialize in go-to-market strategy, messaging and positioning, personas, pricing, and roadmap alignment. In recent roles, I drove 39% new revenue growth in eight months, achieved a 100% competitive win rate against a top competitor, and increased revenue per customer by 12%.',
  'Seattle, Washington',
  'https://www.linkedin.com/in/alisonkcharles',
  'alison.kimble.charles@gmail.com'
);

-- Experience
insert into experience (company, company_context, title, start_date, end_date, bullets, sort_order) values
('Rebrandly', 'B2B SaaS, PLG and SLG hybrid', 'Sr Director of Product Marketing / Head of Marketing', '12/2024', 'Present', '[
  "Drove 39% growth in new PLG business within eight months through better positioning and optimized GTM strategy centered around two core ICPs.",
  "Developed competitive positioning that helped sales achieve a 100% competitive win rate against a top competitor in Q4, 2025.",
  "Revamped pricing models, resulting in a 20% boost in sign-ups and a 12% increase in ARPA within three months through targeted market analysis and customer feedback.",
  "Defined ideal customer profiles, resulting in focused marketing and sales strategy that won 11% more of our best-retaining customers in six months.",
  "Identified a major growth adjacency through customer and market research, directly influencing the 2026 product roadmap."
]', 1),

('Help Scout', 'B2B SaaS, PLG and SLG hybrid', 'Director of Product Marketing', '02/2021', '10/2024', '[
  "Designed and executed GTM strategy for multiple AI features, with results including $438k in incremental ARR within one quarter, 10% adoption within the customer base, and a 15% increase in website traffic.",
  "Led pricing and packaging strategy with multiple stakeholders, driving decisions that led to add-on adoption, a 20% lift in annual vs. monthly plans, and a 5% increase in higher-tier plan selection.",
  "Developed detailed ideal customer profiles through extensive market analysis, leading to a strategic focus on segments with 25-30% win rates, higher ACV, and retention."
]', 2),

('Clever', 'B2B, SLG', 'Director of Product Marketing', '09/2016', '02/2021', '[
  "Empowered Sales to achieve 20% growth during a market downturn through targeted positioning, messaging, and enablement.",
  "Informed the product roadmap through deep customer insight, delivering highest impact product launch in company history with 95% client adoption within 6 months.",
  "Led end-to-end GTM for new products and features, ensuring tight alignment across Product, Sales, and Marketing."
]', 3),

('Twin Technologies', 'B2B, SLG', 'Marketing Manager', '04/2015', '06/2016', '[
  "Translated a complex product suite into clear, compelling messaging for core buyer personas.",
  "Owned creation of all marketing assets, including website, sales enablement content, case studies, and collateral."
]', 4),

('MuleSoft', 'B2B SaaS, SLG', 'Global Campaign Marketing Manager', '04/2014', '04/2015', '[
  "Drove pipeline through integrated, multi-touch campaigns across email, webinars, paid media, content, and events.",
  "Built the company''s first sales enablement playbooks and email programs for BDR and AE teams."
]', 5),

('MarketBridge', 'B2B, SLG', 'Campaign Manager', '09/2011', '04/2014', '[
  "Developed messaging frameworks to translate technical products into clear value for B2B audiences.",
  "Produced high-impact campaign content across email, web, sales materials, presentations, playbooks, and campaigns."
]', 6);

-- Writing Samples
insert into writing_samples (title, sample_type, url, description, company, sort_order) values
('Why we built conversion tracking', 'Blog Post', 'https://www.rebrandly.com/blog/why-we-built-conversion-tracking', 'Product narrative explaining the strategic rationale for building conversion tracking at the link level. Covers the shift from link management to link intelligence.', 'Rebrandly', 1),
('Conversion Tracking Platform', 'Product Page', 'https://www.rebrandly.com/conversion-tracking', 'Product marketing page for Rebrandly''s conversion tracking platform. Includes positioning, competitive comparison, feature breakdown, and implementation steps.', 'Rebrandly', 2);

-- Case Studies
insert into case_studies (title, company, summary, challenge, approach, result, url, sort_order) values
('Conversion Tracking Launch', 'Rebrandly', 'Led the GTM strategy and product narrative for Rebrandly''s conversion tracking platform, a new product category for the company.', 'Rebrandly was known as a link management tool. The new conversion tracking feature needed to shift perception toward link intelligence without alienating the existing user base.', 'Built the product narrative from scratch: blog post explaining the strategic rationale, product page with competitive comparison, and positioning that framed link-level tracking as a workflow improvement over UTM-based attribution.', '39% new revenue growth in eight months. Product page and blog post published as the primary GTM assets.', 'https://www.rebrandly.com/blog/why-we-built-conversion-tracking', 1),
('AI Features GTM', 'Help Scout', 'Designed and executed GTM strategy for multiple AI-powered features at Help Scout.', 'Help Scout needed to launch AI features into a market skeptical of AI in customer support, where trust and human connection are core values.', 'Positioned AI as augmenting human support rather than replacing it. Built GTM around specific use cases and measurable outcomes rather than AI hype.', '$438k incremental ARR in one quarter, 10% adoption across the customer base, 15% increase in website traffic.', null, 2);
