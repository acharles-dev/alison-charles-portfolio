const SUPABASE_URL = window.__SUPABASE_URL__ || '';
const SUPABASE_KEY = window.__SUPABASE_KEY__ || '';

let db;

async function init() {
  if (!SUPABASE_URL || !SUPABASE_KEY) {
    renderStatic();
    return;
  }

  const { createClient } = supabase;
  db = createClient(SUPABASE_URL, SUPABASE_KEY);

  const [profile, experience, caseStudies, samples] = await Promise.all([
    db.from('profile').select('*').single(),
    db.from('experience').select('*').order('sort_order'),
    db.from('case_studies').select('*').order('sort_order'),
    db.from('writing_samples').select('*').order('sort_order'),
  ]);

  if (profile.data) renderHero(profile.data);
  if (experience.data) renderExperience(experience.data);
  if (caseStudies.data) renderCaseStudies(caseStudies.data);
  if (samples.data) renderSamples(samples.data);
}

function renderHero(p) {
  document.getElementById('hero-name').textContent = p.name;
  document.getElementById('hero-headline').textContent = p.headline;
  document.getElementById('hero-location').textContent = p.location;
  document.getElementById('hero-bio').textContent = p.bio;

  const links = document.getElementById('hero-links');
  links.innerHTML = '';
  if (p.linkedin_url) {
    const a = document.createElement('a');
    a.href = p.linkedin_url;
    a.target = '_blank';
    a.textContent = 'LinkedIn';
    links.appendChild(a);
  }
  if (p.email) {
    const a = document.createElement('a');
    a.href = 'mailto:' + p.email;
    a.textContent = p.email;
    links.appendChild(a);
  }
}

function renderExperience(jobs) {
  const el = document.getElementById('experience-list');
  el.innerHTML = jobs.map(j => {
    const bullets = (typeof j.bullets === 'string' ? JSON.parse(j.bullets) : j.bullets) || [];
    return `
      <div class="job">
        <div class="job-header">
          <span>
            <span class="job-company">${esc(j.company)}</span>
            ${j.company_context ? `<span class="job-context"> (${esc(j.company_context)})</span>` : ''}
          </span>
          <span class="job-dates">${esc(j.start_date)} - ${esc(j.end_date)}</span>
        </div>
        <div class="job-title">${esc(j.title)}</div>
        <ul class="job-bullets">
          ${bullets.map(b => `<li>${esc(b)}</li>`).join('')}
        </ul>
      </div>
    `;
  }).join('');
}

function renderCaseStudies(studies) {
  const el = document.getElementById('case-studies-list');
  if (!studies.length) {
    el.closest('section').style.display = 'none';
    return;
  }
  el.innerHTML = studies.map(cs => `
    <div class="case-study">
      <h3>${esc(cs.title)}</h3>
      <div class="cs-company">${esc(cs.company)}</div>
      <p class="cs-summary">${esc(cs.summary)}</p>
      <div class="cs-grid">
        <div>
          <h4>Challenge</h4>
          <p>${esc(cs.challenge)}</p>
        </div>
        <div>
          <h4>Approach</h4>
          <p>${esc(cs.approach)}</p>
        </div>
        <div>
          <h4>Result</h4>
          <p>${esc(cs.result)}</p>
        </div>
      </div>
      ${cs.url ? `<a href="${esc(cs.url)}" target="_blank">View published work &rarr;</a>` : ''}
    </div>
  `).join('');
}

function renderSamples(samples) {
  const el = document.getElementById('samples-list');
  if (!samples.length) {
    el.closest('section').style.display = 'none';
    return;
  }
  el.innerHTML = samples.map(s => `
    <div class="sample">
      <div class="sample-info">
        <h3><a href="${esc(s.url)}" target="_blank">${esc(s.title)}</a></h3>
        <p>${esc(s.description)}</p>
      </div>
      <span class="sample-type">${esc(s.sample_type)}</span>
    </div>
  `).join('');
}

function renderStatic() {
  document.getElementById('hero-name').textContent = 'Alison Charles';
  document.getElementById('hero-headline').textContent = 'Director of Product Marketing';
  document.getElementById('hero-location').textContent = 'Seattle, Washington';
  document.getElementById('hero-bio').textContent =
    'B2B product marketer with 15 years of experience, including six years as a hands-on player-coach. I specialize in go-to-market strategy, messaging and positioning, personas, pricing, and roadmap alignment.';
}

function esc(str) {
  if (!str) return '';
  const d = document.createElement('div');
  d.textContent = str;
  return d.innerHTML;
}

document.addEventListener('DOMContentLoaded', init);
