# 🛡️ Threat Hunting Basics: Caçando Falhas de Logon com PowerShell

Este repositório documenta um laboratório prático de auditoria de segurança e *Threat Hunting* focado na análise de logs de eventos do ecossistema Windows utilizando o PowerShell.

---

## 📋 Cenário e Objetivo

O objetivo deste projeto foi simular e identificar uma das técnicas mais comuns de ataque de vetor de acesso: o **Ataque de Força Bruta (Brute Force)** ou tentativas de login não autorizadas. 

Utilizando o PowerShell, foi realizada uma extração cirúrgica do **Log de Segurança do Windows** para identificar falhas de autenticação, mapeando quem tentou acessar a máquina, quando e de onde veio a tentativa.

---

## 🛠️ Tecnologias e Comandos Utilizados

*   **Ambiente:** Windows 10/11 / Windows Server (PowerShell em modo Administrador)
*   **Mecanismo:** Windows Event Viewer (Visualizador de Eventos)
*   **Comando Principal:** `Get-WinEvent`

---

## 🚀 Passo a Passo do Laboratório

### 1. Simulação do Alerta
Para gerar uma evidência real no sistema, a tela do Windows foi bloqueada (`Win + L`) e foram realizadas tentativas intencionais de logon com credenciais incorretas, gerando o **ID de Evento 4625** (Falha de Logon).

### 2. Coleta e Filtragem dos Dados
Para extrair os eventos gerados sem sobrecarregar a memória, foi utilizada uma tabela de filtragem (*Hashtable*), que é a prática recomendada em auditorias reais por ser extremamente performática:

```powershell
# Extrai o último evento de falha de logon gerado no sistema
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 1 | Format-List TimeCreated, Message
