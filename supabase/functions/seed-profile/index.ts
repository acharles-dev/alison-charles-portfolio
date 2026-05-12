import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

Deno.serve(async () => {
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  );

  const { data: existing } = await supabase.from("profile").select("id");
  if (existing && existing.length > 0) {
    return new Response(JSON.stringify({ message: "Profile already exists" }));
  }

  const { error } = await supabase.from("profile").insert({
    name: "Alison Charles",
    headline: "Director of Product Marketing",
    bio: "B2B product marketer with 15 years of experience, including six years as a hands-on player-coach. I specialize in go-to-market strategy, messaging and positioning, personas, pricing, and roadmap alignment. In recent roles, I drove 39% new revenue growth in eight months, achieved a 100% competitive win rate against a top competitor, and increased revenue per customer by 12%.",
    location: "Seattle, Washington",
    linkedin_url: "https://www.linkedin.com/in/alisonkcharles",
    email: "alison.kimble.charles@gmail.com",
  });

  // Also seed writing samples and case studies if empty
  const { data: samples } = await supabase.from("writing_samples").select("id");
  if (!samples || samples.length === 0) {
    await supabase.from("writing_samples").insert([
      { title: "Why we built conversion tracking", sample_type: "Blog Post", url: "https://www.rebrandly.com/blog/why-we-built-conversion-tracking", description: "Product narrative explaining the strategic rationale for building conversion tracking at the link level.", company: "Rebrandly", sort_order: 1 },
      { title: "Conversion Tracking Platform", sample_type: "Product Page", url: "https://www.rebrandly.com/conversion-tracking", description: "Product marketing page with positioning, competitive comparison, feature breakdown, and implementation steps.", company: "Rebrandly", sort_order: 2 },
    ]);
  }

  const { data: cases } = await supabase.from("case_studies").select("id");
  if (!cases || cases.length === 0) {
    await supabase.from("case_studies").insert([
      { title: "Conversion Tracking Launch", company: "Rebrandly", summary: "Led the GTM strategy and product narrative for Rebrandly's conversion tracking platform.", challenge: "Rebrandly was known as a link management tool. The new feature needed to shift perception toward link intelligence without alienating the existing user base.", approach: "Built the product narrative from scratch: blog post explaining the strategic rationale, product page with competitive comparison, and positioning that framed link-level tracking as a workflow improvement over UTM-based attribution.", result: "39% new revenue growth in eight months.", url: "https://www.rebrandly.com/blog/why-we-built-conversion-tracking", sort_order: 1 },
      { title: "AI Features GTM", company: "Help Scout", summary: "Designed and executed GTM strategy for multiple AI-powered features.", challenge: "Help Scout needed to launch AI features into a market skeptical of AI in customer support.", approach: "Positioned AI as augmenting human support rather than replacing it. Built GTM around specific use cases and measurable outcomes.", result: "$438k incremental ARR in one quarter, 10% adoption across the customer base, 15% increase in website traffic.", url: null, sort_order: 2 },
    ]);
  }

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }

  return new Response(JSON.stringify({ seeded: true }));
});
