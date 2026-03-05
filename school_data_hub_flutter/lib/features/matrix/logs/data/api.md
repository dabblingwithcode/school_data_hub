## Logs

### GET list logs

List stored log entries (newest first). Optional query: `limit` (default 50, max 500), `offset` (default 0).

```bash
curl -s -X GET \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs"
```

With pagination:

```bash
curl -s -X GET \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs?limit=100&offset=0"
```

**Response (200):** `{"logs":[{"id":"...","time":"...","level":"info","message":"...","fields":{...}}],"total":N}`

---

### DELETE one log

Delete a single log entry by id.

```bash
curl -s -X DELETE \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs/123"
```

**Response (204):** no body  
**Errors:** `400` – missing log id; `404` – log entry not found.

---

### DELETE all logs

Clear all stored log entries.

```bash
curl -s -X DELETE \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs"
```

**Response (204):** no body

---

### GET logs config

Return which log levels are currently stored (e.g. debug on/off).

```bash
curl -s -X GET \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs/config"
```

**Response (200):** `{"levels":{"trace":false,"debug":false,"info":true,"warning":true,"error":true,"fatal":true,"panic":true}}`

---

### PUT logs config

Set which log levels to store. Only levels you send are applied; others are unchanged. At least one level is required.

Exclude debug (default-like):

```bash
curl -s -X PUT \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"levels":{"debug":false,"info":true,"warning":true,"error":true,"fatal":true,"panic":true}}' \
  "http://localhost:41081/_matrix/corporal/logs/config"
```## Logs

### GET list logs

List stored log entries (newest first). Optional query: `limit` (default 50, max 500), `offset` (default 0).

```bash
curl -s -X GET \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs"
```

With pagination:

```bash
curl -s -X GET \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs?limit=100&offset=0"
```

**Response (200):** `{"logs":[{"id":"...","time":"...","level":"info","message":"...","fields":{...}}],"total":N}`

---

### DELETE one log

Delete a single log entry by id.

```bash
curl -s -X DELETE \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs/123"
```

**Response (204):** no body  
**Errors:** `400` – missing log id; `404` – log entry not found.

---

### DELETE all logs

Clear all stored log entries.

```bash
curl -s -X DELETE \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs"
```

**Response (204):** no body

---

### GET logs config

Return which log levels are currently stored (e.g. debug on/off).

```bash
curl -s -X GET \
  -H "Authorization: Bearer YOUR_TOKEN" \
  "http://localhost:41081/_matrix/corporal/logs/config"
```

**Response (200):** `{"levels":{"trace":false,"debug":false,"info":true,"warning":true,"error":true,"fatal":true,"panic":true}}`

---

### PUT logs config

Set which log levels to store. Only levels you send are applied; others are unchanged. At least one level is required.

Exclude debug (default-like):

```bash
curl -s -X PUT \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"levels":{"debug":false,"info":true,"warning":true,"error":true,"fatal":true,"panic":true}}' \
  "http://localhost:41081/_matrix/corporal/logs/config"
```

Include debug:

```bash
curl -s -X PUT \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"levels":{"debug":true,"info":true}}' \
  "http://localhost:41081/_matrix/corporal/logs/config"
```

**Response (200):** `{"levels":{...}}` (current filter after update)  
**Errors:** `400` – bad JSON or empty `levels`.

---

Include debug:

```bash
curl -s -X PUT \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"levels":{"debug":true,"info":true}}' \
  "http://localhost:41081/_matrix/corporal/logs/config"
```

**Response (200):** `{"levels":{...}}` (current filter after update)  
**Errors:** `400` – bad JSON or empty `levels`.

---