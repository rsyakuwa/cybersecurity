## 🧠 Alinhamento Estratégico: Os 8 Domínios do CISSP
![Framework-CISSP](https://img.shields.io/badge/Framework-CISSP_(ISC²)-005F9E?style=for-the-badge&logo=security&logoColor=white)

Utilizo a estrutura de frameworks de mercado reconhecidos internacionalmente, como o **CISSP (ISC²)**, para guiar meus estudos e documentar competências em Cibersegurança, garantindo uma visão holística que une governança gerencial a operações técnicas.

---

### 🏛️ Domínio 1: Segurança e Gerenciamento de Riscos (Security and Risk Management)

*   **Definição:** É o maior domínio do framework e serve como a base de toda a estratégia de segurança da informação. Ele aborda diretamente a governança de segurança corporativa, conformidade legal e regulatória, desenvolvimento de políticas de segurança, os conceitos fundamentais de confidencialidade, integridade e disponibilidade (**Tríade CID**), além da gestão de continuidade de negócios e metodologias de gerenciamento de riscos.
*   **Evidências de Aplicação Prática & Validação:**
    *   🏅 **Certificação IBM:** *Governance, Risk, Compliance, and Data Privacy* — Validação de conhecimentos em mapeamento de riscos, auditoria de conformidade e implementação de processos alinhados a regulamentações de privacidade (LGPD/GDPR).
    *   🏅 **Certificação IBM:** *Cybersecurity Fundamentals* — Consolidação dos conceitos essenciais de arquitetura de segurança, vetores de ameaças atuais e aplicação prática da Tríade CID no ambiente corporativo.
    *   🏅 **Certificação Google:** *IT Support Professional Certificate* — Base sólida em governança de TI, infraestrutura de sistemas e gerenciamento de ativos críticos.
 
---

### 📦 Domínio 2: Segurança de Ativos (Asset Security)

*   **Definição:** Focado na proteção física e lógica dos dados ao longo de todo o seu ciclo de vida. Aborda a classificação da informação, propriedade de dados, níveis de privacidade, retenção segura, destruição de ativos e a proteção de dados em repouso e em trânsito.
*   **Evidências de Aplicação Prática & Validação:**
    *   🛠️ **Projeto Prático:** [Simulador de DLP - Proteção de Dados (PowerShell)](./automacao-e-scripts/powershell-dlp-simulator/) — Engenharia de detecção focada na busca automatizada de dados sensíveis (PII / CPFs) e isolamento lógico em quarentena para garantia de conformidade com a LGPD.

---

### 🏗️ Domínio 3: Engenharia e Arquitetura de Segurança (Security Architecture and Engineering)

*   **Definição:** Trata do design e da implementação de sistemas e infraestruturas seguras utilizando princípios de engenharia. Inclui a compreensão de modelos de segurança, vulnerabilidades em arquiteturas de sistemas, criptografia (simétrica/assimétrica) e controles de segurança física/ambiental.
*   **Evidências de Aplicação Prática & Validação:**
    *   🛠️ **Projeto Prático:** [Auditor de Hardening e Conformidade (PowerShell)](./automacao-e-scripts/powershell-security-hardening/) — Automação voltada para avaliar a linha de base de segurança (*Security Baseline*) do sistema operacional, auditando o status do Firewall, Antivírus e mitigando superfícies de ataque.

---

### 🌐 Domínio 4: Comunicação e Segurança de Rede (Communication and Network Security)

*   **Definição:** Abrange a infraestrutura física e lógica que suporta as comunicações de dados. Foca na arquitetura de canais de transmissão seguros, protocolos de rede (TCP/IP, DNS, DHCP), segmentação de rede, firewalls, roteamento, switching e prevenção de ataques à rede.
*   **Evidências de Aplicação Prática & Validação:**
    *   💼 **Experiência Profissional:** Sólido histórico no suporte a infraestruturas de redes corporativas em ambientes altamente sensíveis (Setor Financeiro, Mesa de Operações e Câmbio), atuando diretamente na identificação de falhas de conectividade e análise de fluxos de dados.

---

### 🔑 Domínio 5: Gestão de Identidade e Acesso (Identity and Access Management - IAM)

*   **Definição:** Foca no controle e no monitoramento do acesso a sistemas e dados confidenciais, garantindo que apenas usuários autorizados tenham acesso aos recursos certos. Aborda autenticação multifator (MFA), provisionamento, ciclo de vida de identidades e o Princípio do Privilégio Mínimo.
*   **Evidências de Aplicação Prática & Validação:**
    *   🛠️ **Capacitação Técnica:** Estudos de cenários corporativos focados em Segurança de Identidades Baseada em Privilégios através da plataforma líder de mercado **CyberArk**.
    *   🔍 **Auditoria de Privilégios:** O script de Hardening desenvolvido possui um módulo dedicado à auditoria contínua de contas com privilégios administrativos excessivos acumulados (*Privilege Creep*).

---

### 🔍 Domínio 6: Avaliação e Testes de Segurança (Security Assessment and Testing)

*   **Definição:** Envolve a avaliação contínua dos controles de segurança para garantir que eles permaneçam eficazes. Aborda a execução de testes de vulnerabilidades, auditorias de conformidade, análises de logs de auditoria e a entrega de relatórios para apoiar decisões de governança.
*   **Evidências de Aplicação Prática & Validação:**
    *   📄 **Geração de Evidências:** Implementação de funções estruturadas de logs (`auditoria_hardening.log`) com carimbos de tempo padronizados (*timestamps*) nos scripts de auditoria local, simulando a geração de rastros auditáveis para validação de conformidade corporativa.

---

### 🚨 Domínio 7: Operações de Segurança (Security Operations - SecOps)

*   **Definição:** É o dia a dia da defesa cibernética. Inclui suporte a investigações, monitoramento de eventos, resposta a incidentes, gerenciamento de patches, recuperação de desastres e detecção ativa de ameaças (*Threat Hunting*).
*   **Evidências de Aplicação Prática & Validação:**
    *   🛠️ **Projeto Prático:** [Threat Hunting - Falhas de Logon (PowerShell)](./automacao-e-scripts/powershell-threat-hunting-logon/) — Desenvolvimento de um *Mini-SIEM* para extração e análise em tempo real do Event ID 4625 no Windows, mapeando tentativas de força bruta e anomalias de acessos.

---

### 💻 Domínio 8: Segurança no Desenvolvimento de Software (Software Development Security)

*   **Definição:** Aplica conceitos de segurança ao ciclo de vida do desenvolvimento de sistemas (SDLC). Aborda o uso de boas práticas de codificação, tratamento seguro de exceções, revisão de código e a garantia de que as ferramentas desenvolvidas internamente não introduzam novas vulnerabilidades.
*   **Evidências de Aplicação Prática & Validação:**
    *   ⚙️ **Prática de Código Seguro:** Desenvolvimento de scripts em PowerShell modulares, utilizando funções limpas, escopos restritos e estruturas lógicas otimizadas para processamento de alto desempenho sem impactar os ativos de produção.
